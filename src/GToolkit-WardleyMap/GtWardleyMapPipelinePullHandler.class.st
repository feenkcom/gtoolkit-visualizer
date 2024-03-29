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
GtWardleyMapPipelinePullHandler >> dragEndEvent: anEvent [

	"Reset the element elevation to the default value."
	anEvent currentTarget zIndex: self containerElement defaultNodeElevationIndex.

	super dragEndEvent: anEvent
]

{ #category : #'event handling' }
GtWardleyMapPipelinePullHandler >> dragStartEvent: anEvent [
	anEvent currentTarget relocate: anEvent currentTarget position.
	
	"Elevate the element to ensure that it is on top of other elements while dragging."
	anEvent currentTarget zIndex: self containerElement draggingPipelineElevationIndex.
	
	super dragStartEvent: anEvent
]

{ #category : #initialization }
GtWardleyMapPipelinePullHandler >> initialize [
	super initialize.
	
	pulledAction := [ :aPulledElement :aNormalizedPosition |  ]
]

{ #category : #'event handling' }
GtWardleyMapPipelinePullHandler >> onPulled: aPulledElement from: aPreviousPosition to: aNewPosition  by: aDragDelta starting: anOriginalPosition [
	| aNewRelativePosition aContainerExtent aNewPositionWithoutOffset aNodeViewModel anOffset |
	super onPulled: aPulledElement from: aPreviousPosition to: aNewPosition  by: aDragDelta starting: anOriginalPosition.

	aNodeViewModel := aPulledElement wardleyMapNodeViewModel.
	
	"Pipeline widget uses a layout constraint offset.
	Let's subtract that offset value to compute proper aNewRelativePosition.
	Note that aNewPosition is a top-left pipeline element corner point,
	not the pipeline center point."
	anOffset := GtWardleyMapUtility computePipelineViewModelVerticalTopOffset: aNodeViewModel.
	aNewPositionWithoutOffset := aNewPosition - (0 @ anOffset).
	
	aContainerExtent := self containerElement extent.
	aNewRelativePosition := (aContainerExtent x isZero or: [ aContainerExtent y isZero ])
		ifTrue: [ 0@0 ]
		ifFalse: [ aNewPositionWithoutOffset / aContainerExtent ].
	
	pulledAction value: aPulledElement value: aNewRelativePosition
]

{ #category : #'api - event managing' }
GtWardleyMapPipelinePullHandler >> wantsEvent: anEvent [
	^ (super wantsEvent: anEvent) and: [ anEvent modifiers isPrimaryModifier not ]
]

{ #category : #initialization }
GtWardleyMapPipelinePullHandler >> whenPulled: aBlockClosure [
	pulledAction := aBlockClosure
]
