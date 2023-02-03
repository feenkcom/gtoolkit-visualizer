"
I am a specialized pull handler that transforms the absolute position into a normalized proportional position for the frame layout alignment

I compute a relative new position that is considered to be a left and top values of an element: {{gtMethod:GtWardleyMapPipelinePullHandler >> #onPulled:from:to:by:starting: | expanded=true | label=#selector }}
"
Class {
	#name : #GtWardleyMapPipelinePullHandler,
	#superclass : #BlPullHandler,
	#instVars : [
		'containerElement',
		'pulledAction'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #accessing }
GtWardleyMapPipelinePullHandler >> containerElement [
	^ containerElement
]

{ #category : #accessing }
GtWardleyMapPipelinePullHandler >> containerElement: anObject [
	containerElement := anObject
]

{ #category : #'event handling' }
GtWardleyMapPipelinePullHandler >> dragStartEvent: anEvent [
	anEvent currentTarget relocate: anEvent currentTarget position.
	super dragStartEvent: anEvent
]

{ #category : #initialization }
GtWardleyMapPipelinePullHandler >> initialize [
	super initialize.
	
	pulledAction := [ :aPulledElement :aNormalizedPosition |  ]
]

{ #category : #'event handling' }
GtWardleyMapPipelinePullHandler >> onPulled: aPulledElement from: aPreviousPosition to: aNewPosition  by: aDragDelta starting: anOriginalPosition [
	| newRelativePosition aContainerExtent |
	super onPulled: aPulledElement from: aPreviousPosition to: aNewPosition  by: aDragDelta starting: anOriginalPosition.

	aContainerExtent := self containerElement extent.
	newRelativePosition := (aContainerExtent x isZero or: [ aContainerExtent y isZero ])
		ifTrue: [ 0@0 ]
		ifFalse: [ aNewPosition / aContainerExtent ].
	
	pulledAction cull: aPulledElement cull: newRelativePosition cull: nil
]

{ #category : #'api - event managing' }
GtWardleyMapPipelinePullHandler >> wantsEvent: anEvent [
	^ (super wantsEvent: anEvent) and: [ anEvent modifiers isPrimaryModifier not ]
]

{ #category : #initialization }
GtWardleyMapPipelinePullHandler >> whenPulled: aBlockClosure [
	pulledAction := aBlockClosure
]
