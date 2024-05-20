Class {
	#name : #GtWardleyMapNotePullHandler,
	#superclass : #BlPullHandler,
	#instVars : [
		'containerElement',
		'pulledAction'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #accessing }
GtWardleyMapNotePullHandler >> containerElement [
	^ containerElement
]

{ #category : #accessing }
GtWardleyMapNotePullHandler >> containerElement: anObject [
	containerElement := anObject
]

{ #category : #'event handling' }
GtWardleyMapNotePullHandler >> dragEndEvent: anEvent [
	| aPulledElement |
	aPulledElement := self targetElementFor: anEvent.
	
	"Reset the element elevation to the default value."
	anEvent currentTarget zIndex: self containerElement defaultNoteElevationIndex.

	super dragEndEvent: anEvent
]

{ #category : #'event handling' }
GtWardleyMapNotePullHandler >> dragStartEvent: anEvent [
	anEvent currentTarget relocate: anEvent currentTarget position.

	"Elevate the element to ensure that it is on top of other elements while dragging."
	anEvent currentTarget zIndex: self containerElement draggingNoteElevationIndex.
	
	super dragStartEvent: anEvent
]

{ #category : #initialization }
GtWardleyMapNotePullHandler >> initialize [
	super initialize.
	
	pulledAction := [ :aPulledElement :aNormalizedPosition |  ].
]

{ #category : #'event handling' }
GtWardleyMapNotePullHandler >> onPulled: aPulledElement from: aPreviousPosition to: aNewPosition by: aDragDelta starting: anOriginalPosition [
	| aNewRelativePosition aContainerExtent aNoteViewModel |
	super
		onPulled: aPulledElement
		from: aPreviousPosition
		to: aNewPosition
		by: aDragDelta
		starting: anOriginalPosition.

	aNoteViewModel := aPulledElement wardleyMapNoteViewModel.
	
	aContainerExtent := self containerElement extent.
	aNewRelativePosition := (aContainerExtent x isZero
			or: [ aContainerExtent y isZero ])
			ifTrue: [ 0 @ 0 ]
			ifFalse: [ (aNewPosition + (aPulledElement extent / 2.0)) / aContainerExtent ].

	pulledAction value: aPulledElement value: aNewRelativePosition.
]

{ #category : #'api - event managing' }
GtWardleyMapNotePullHandler >> wantsEvent: anEvent [
	^ (super wantsEvent: anEvent) and: [ anEvent modifiers isPrimaryModifier not ]
]

{ #category : #initialization }
GtWardleyMapNotePullHandler >> whenPulled: aBlockClosure [
	pulledAction := aBlockClosure
]
