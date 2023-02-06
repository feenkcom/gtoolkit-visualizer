Class {
	#name : #GtWardleyMapNodePullHandler,
	#superclass : #BlPullHandler,
	#instVars : [
		'containerElement',
		'pulledAction',
		'dragEndAction',
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
	NonInteractiveTranscript stdout
		show: 'drag end event, original position: ';
		show: originalPosition;
		show: ', delta: ';
		show: anEvent currentTarget constraints position - originalPosition;
		cr.

	dragEndAction
		value: (self targetElementFor: anEvent)
		value: (pullDirection ifNil: [ GtWardleyMapNodeVerticalPullDirection ]).
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
	dragEndAction := [ :aPulledElement :aPullDirection |  ]
]

{ #category : #'event handling' }
GtWardleyMapNodePullHandler >> onPulled: aPulledElement from: aPreviousPosition to: aNewPosition by: aDragDelta starting: anOriginalPosition [
	| newRelativePosition aContainerExtent |
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

	pullDirection := GtWardleyMapNodePullDirection fromDragDelta: aDragDelta.

	pulledAction value: aPulledElement value: newRelativePosition
]

{ #category : #'api - event managing' }
GtWardleyMapNodePullHandler >> wantsEvent: anEvent [
	^ (super wantsEvent: anEvent) and: [ anEvent modifiers isPrimaryModifier not ]
]

{ #category : #initialization }
GtWardleyMapNodePullHandler >> whenFinished: aBlockClosure [
	dragEndAction := aBlockClosure
]

{ #category : #initialization }
GtWardleyMapNodePullHandler >> whenPulled: aBlockClosure [
	pulledAction := aBlockClosure
]
