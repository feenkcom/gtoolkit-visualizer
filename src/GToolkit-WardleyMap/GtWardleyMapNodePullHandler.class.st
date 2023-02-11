Class {
	#name : #GtWardleyMapNodePullHandler,
	#superclass : #BlPullHandler,
	#instVars : [
		'containerElement',
		'pulledAction',
		'pullDirection'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #accessing }
GtWardleyMapNodePullHandler >> containerElement [
	^ containerElement
]

{ #category : #accessing }
GtWardleyMapNodePullHandler >> containerElement: anObject [
	containerElement := anObject
]

{ #category : #'event handling' }
GtWardleyMapNodePullHandler >> dragEndEvent: anEvent [
	| aPulledElement aPullDirection |
	aPulledElement := self targetElementFor: anEvent.
	aPullDirection := pullDirection ifNil: [ GtWardleyMapNodeVerticalPullDirection ].

	aPullDirection onPullFinished: aPulledElement mapElement: self containerElement.
	
	super dragEndEvent: anEvent
]

{ #category : #'event handling' }
GtWardleyMapNodePullHandler >> dragStartEvent: anEvent [
	anEvent currentTarget relocate: anEvent currentTarget position.
	super dragStartEvent: anEvent
]

{ #category : #initialization }
GtWardleyMapNodePullHandler >> initialize [
	super initialize.
	
	pulledAction := [ :aPulledElement :aNormalizedPosition |  ].
]

{ #category : #'event handling' }
GtWardleyMapNodePullHandler >> onPulled: aPulledElement from: aPreviousPosition to: aNewPosition by: aDragDelta starting: anOriginalPosition [
	| aNewRelativePosition aContainerExtent aPullDirection aNodeViewModel aNewPositionWithoutOffset |
	super
		onPulled: aPulledElement
		from: aPreviousPosition
		to: aNewPosition
		by: aDragDelta
		starting: anOriginalPosition.

	aNodeViewModel := aPulledElement wardleyMapNodeViewModel.
	
	aNewPositionWithoutOffset := aNodeViewModel pipelineNodeViewModel 
		ifNil: [ aNewPosition ]
		ifNotNil: [ :aPipelineNodeViewModel | 
			"Pipeline widget is right below the node widget.
			Let's subtract half of the node size to get proper y-node-coordinate"
			aNewPosition 
				- (0 @ (((aPipelineNodeViewModel nodeSize y / 2) 
					+ (GtWardleyMapConstants  pipelineHeight / 2)) asFloat)) ].
		
	aContainerExtent := self containerElement extent.
	aNewRelativePosition := (aContainerExtent x isZero
			or: [ aContainerExtent y isZero ])
			ifTrue: [ 0 @ 0 ]
			ifFalse: [ (aNewPositionWithoutOffset + (aPulledElement extent / 2.0)) / aContainerExtent ].

	pullDirection := aPullDirection := GtWardleyMapNodePullDirection fromDragDelta: aDragDelta.
	
	pulledAction value: aPulledElement value: aNewRelativePosition.
	
	aPullDirection onPulled: aPulledElement mapElement: self containerElement.
]

{ #category : #'api - event managing' }
GtWardleyMapNodePullHandler >> wantsEvent: anEvent [
	^ (super wantsEvent: anEvent) and: [ anEvent modifiers isPrimaryModifier not ]
]

{ #category : #initialization }
GtWardleyMapNodePullHandler >> whenPulled: aBlockClosure [
	pulledAction := aBlockClosure
]
