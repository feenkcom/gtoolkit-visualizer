"
I am a {{gtClass: BlPullHandler}}. 
I know how to drag {{gtClass: GtWardleyMapNodeElement}} instances.
"
Class {
	#name : #GtWardleyMapNodePullHandler,
	#superclass : #BlPullHandler,
	#instVars : [
		'containerElement',
		'minHorizontalCoordinate',
		'maxHorizontalCoordinate',
		'pulledAction'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #initialization }
GtWardleyMapNodePullHandler >> beWithPipelineMin: aMinHorizontalCoordinate max: aMaxHorizontalCoordinate [
	self beHorizontal.
	minHorizontalCoordinate := aMinHorizontalCoordinate.
	maxHorizontalCoordinate := aMaxHorizontalCoordinate
]

{ #category : #initialization }
GtWardleyMapNodePullHandler >> beWithoutPipeline [
	self beFree.
	minHorizontalCoordinate := 0.
	maxHorizontalCoordinate := 1
]

{ #category : #accessing }
GtWardleyMapNodePullHandler >> containerElement [
	^ containerElement
]

{ #category : #accessing }
GtWardleyMapNodePullHandler >> containerElement: anObject [
	containerElement := anObject
]

{ #category : #'event handling' }
GtWardleyMapNodePullHandler >> dragStartEvent: anEvent [
	anEvent currentTarget relocate: anEvent currentTarget position.
	super dragStartEvent: anEvent
]

{ #category : #'api - accessing' }
GtWardleyMapNodePullHandler >> eventsToHandle [
	^ super eventsToHandle
		, {GtWardleyMapNodeElementWithPipelineEvent.
				GtWardleyMapNodeElementWithoutPipelineEvent}
]

{ #category : #initialization }
GtWardleyMapNodePullHandler >> initialize [
	super initialize.

	minHorizontalCoordinate := 0.
	maxHorizontalCoordinate := 1.
	
	pulledAction := [ :aPulledElement :aNormalizedPosition |  ].
]

{ #category : #testing }
GtWardleyMapNodePullHandler >> isHorizontal [
	^ direction = Horizontal
]

{ #category : #'event handling' }
GtWardleyMapNodePullHandler >> onPulled: aPulledElement from: aPreviousPosition to: aNewPosition by: aDragDelta starting: anOriginalPosition [
	| aContainerExtent newRelativePosition |
	super
		onPulled: aPulledElement
		from: aPreviousPosition
		to: aNewPosition
		by: aDragDelta
		starting: anOriginalPosition.
	aContainerExtent := self containerElement extent.
	newRelativePosition := (aContainerExtent x isZero
			or: [ aContainerExtent y isZero ])
			ifTrue: [ 0 @ 0 ]
			ifFalse: [ (aNewPosition + (aPulledElement extent / 2.0)) / aContainerExtent ].
	self isHorizontal
		ifTrue: [ newRelativePosition := ((minHorizontalCoordinate max: newRelativePosition x)
					min: maxHorizontalCoordinate) @ newRelativePosition y ].
	pulledAction
		cull: aPulledElement
		cull: newRelativePosition
		cull: nil
]

{ #category : #'event handling' }
GtWardleyMapNodePullHandler >> relativePositionOf: aPulledElement fromPosition: aNewPosition [
	| aContainerExtent newRelativePosition |
	aContainerExtent := self containerElement extent.

	newRelativePosition := (aContainerExtent x isZero
			or: [ aContainerExtent y isZero ])
			ifTrue: [ 0 @ 0 ]
			ifFalse: [ (aNewPosition + (aPulledElement extent / 2.0)) / aContainerExtent ].

	self isHorizontal
		ifTrue: [ newRelativePosition := ((minHorizontalCoordinate max: newRelativePosition x)
					min: maxHorizontalCoordinate) @ newRelativePosition y ].
	^ newRelativePosition
]

{ #category : #'api - event managing' }
GtWardleyMapNodePullHandler >> wantsEvent: anEvent [
	(super wantsEvent: anEvent) ifFalse: [ ^ false ].

	anEvent isBaseDrag ifTrue: [ ^ anEvent modifiers isPrimaryModifier not ].

	^ anEvent isWardleyMapNodeElementPipelineEvent
]

{ #category : #'event handling' }
GtWardleyMapNodePullHandler >> wardleyMapNodeElementWithPipelineEvent: anEvent [
	anEvent consumed: true.
	self
		beWithPipelineMin: anEvent minHorizontalCoordinate
		max: anEvent maxHorizontalCoordinate
]

{ #category : #'event handling' }
GtWardleyMapNodePullHandler >> wardleyMapNodeElementWithoutPipelineEvent: anEvent [
	anEvent consumed: true.
	self beWithoutPipeline
]

{ #category : #initialization }
GtWardleyMapNodePullHandler >> whenPulled: aBlockClosure [
	pulledAction := aBlockClosure
]
