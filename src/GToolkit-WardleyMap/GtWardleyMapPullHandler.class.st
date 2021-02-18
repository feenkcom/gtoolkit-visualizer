Class {
	#name : #GtWardleyMapPullHandler,
	#superclass : #BlPullHandler,
	#instVars : [
		'containerElement'
	],
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #accessing }
GtWardleyMapPullHandler >> containerElement [
	^ containerElement
]

{ #category : #accessing }
GtWardleyMapPullHandler >> containerElement: anObject [
	containerElement := anObject
]

{ #category : #'event handling' }
GtWardleyMapPullHandler >> dragStartEvent: anEvent [
	anEvent currentTarget relocate: anEvent currentTarget position.
	super dragStartEvent: anEvent
]

{ #category : #'event handling' }
GtWardleyMapPullHandler >> onPulled: aPulledElement from: aPreviousPosition to: aNewPosition  by: aDragDelta starting: anOriginalPosition [
	| newRelativePosition aContainerExtent |
	super onPulled: aPulledElement from: aPreviousPosition to: aNewPosition  by: aDragDelta starting: anOriginalPosition.

	aContainerExtent := self containerElement extent.
	newRelativePosition := (aContainerExtent x isZero or: [ aContainerExtent y isZero ])
		ifTrue: [ 0@0 ]
		ifFalse: [ (aNewPosition + (aPulledElement extent / 2.0)) / aContainerExtent ].

	aPulledElement constraintsDo: [ :c |
		c frame horizontal alignCenterAt: newRelativePosition x.
		c frame vertical alignCenterAt: newRelativePosition y ]
]
