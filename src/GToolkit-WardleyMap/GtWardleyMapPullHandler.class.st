"
I am a specialized pull handler that transforms the absolute position into a normalized proportional position for the frame layout alignment

I compute a relative new position that is considered to be a center of an element: {{gtMethod:GtWardleyMapPullHandler >> #onPulled:from:to:by:starting: | expanded=true | label=#selector }}
"
Class {
	#name : #GtWardleyMapPullHandler,
	#superclass : #BlPullHandler,
	#instVars : [
		'containerElement',
		'pulledAction',
		'dradEndAction'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
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

{ #category : #initialization }
GtWardleyMapPullHandler >> initialize [
	super initialize.
	
	pulledAction := [ :aPulledElement :aNormalizedPosition |  ]
]

{ #category : #'event handling' }
GtWardleyMapPullHandler >> onPulled: aPulledElement from: aPreviousPosition to: aNewPosition  by: aDragDelta starting: anOriginalPosition [
	| newRelativePosition aContainerExtent |
	super onPulled: aPulledElement from: aPreviousPosition to: aNewPosition  by: aDragDelta starting: anOriginalPosition.

	aContainerExtent := self containerElement extent.
	newRelativePosition := (aContainerExtent x isZero or: [ aContainerExtent y isZero ])
		ifTrue: [ 0@0 ]
		ifFalse: [ (aNewPosition + (aPulledElement extent / 2.0)) / aContainerExtent ].
	
	pulledAction value: aPulledElement value: newRelativePosition
]

{ #category : #'api - event managing' }
GtWardleyMapPullHandler >> wantsEvent: anEvent [
	^ (super wantsEvent: anEvent) and: [ anEvent modifiers isPrimaryModifier not ]
]

{ #category : #initialization }
GtWardleyMapPullHandler >> whenPulled: aBlockClosure [
	pulledAction := aBlockClosure
]
