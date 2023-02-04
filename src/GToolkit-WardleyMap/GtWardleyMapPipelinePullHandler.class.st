"
I am a specialized pull handler that transforms the absolute position into a normalized proportional position for the frame layout alignment

I compute a relative new position that is considered to be a left and top values of an element: {{gtMethod:GtWardleyMapPipelinePullHandler >> #onPulled:from:to:by:starting: | expanded=true | label=#selector }}
"
Class {
	#name : #GtWardleyMapPipelinePullHandler,
	#superclass : #BlPullHandler,
	#instVars : [
		'containerElement',
		'pulledAction',
		'innerNodeElements'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #'event handling' }
GtWardleyMapPipelinePullHandler >> collectInnerNodesFor: aNodePipelineElement [
	self containerElement ifNil: [ ^ #() ].

	^ Array
		streamContents: [ :aStream | 
			self containerElement
				childrenDo: [ :eachChild | 
					(eachChild graph isNode
						and: [ | aChildViewModel |
							aChildViewModel := eachChild wardleyMapNodeViewModel.
							aChildViewModel isPipelineVisible not
								and: [ (eachChild == aNodePipelineElement) not
										and: [ aNodePipelineElement bounds inParent asRectangle
												containsRect: eachChild bounds inParent asRectangle ] ] ])
						ifTrue: [ aStream nextPut: eachChild ] ] ]
]

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
	innerNodeElements := nil.

	super dragEndEvent: anEvent
]

{ #category : #'event handling' }
GtWardleyMapPipelinePullHandler >> dragStartEvent: anEvent [
	innerNodeElements := self collectInnerNodesFor: anEvent currentTarget.

	anEvent currentTarget relocate: anEvent currentTarget position.
	super dragStartEvent: anEvent
]

{ #category : #initialization }
GtWardleyMapPipelinePullHandler >> initialize [
	super initialize.
	
	pulledAction := [ :aPulledElement :aNormalizedPosition :innerNodeElements |  ]
]

{ #category : #'event handling' }
GtWardleyMapPipelinePullHandler >> onPulled: aPulledElement from: aPreviousPosition to: aNewPosition  by: aDragDelta starting: anOriginalPosition [
	| newRelativePosition aContainerExtent |
	super onPulled: aPulledElement from: aPreviousPosition to: aNewPosition  by: aDragDelta starting: anOriginalPosition.

	aContainerExtent := self containerElement extent.
	newRelativePosition := (aContainerExtent x isZero or: [ aContainerExtent y isZero ])
		ifTrue: [ 0@0 ]
		ifFalse: [ aNewPosition / aContainerExtent ].
	
	pulledAction cull: aPulledElement cull: newRelativePosition cull: (innerNodeElements ifNil: [ #() ])
]

{ #category : #'api - event managing' }
GtWardleyMapPipelinePullHandler >> wantsEvent: anEvent [
	^ (super wantsEvent: anEvent) and: [ anEvent modifiers isPrimaryModifier not ]
]

{ #category : #initialization }
GtWardleyMapPipelinePullHandler >> whenPulled: aBlockClosure [
	pulledAction := aBlockClosure
]
