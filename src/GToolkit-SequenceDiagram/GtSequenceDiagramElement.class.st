Class {
	#name : #GtSequenceDiagramElement,
	#superclass : #BrHorizontalGrid,
	#traits : 'TGtWithSequenceDiagramViewModel',
	#classTraits : 'TGtWithSequenceDiagramViewModel classTrait',
	#category : #'GToolkit-SequenceDiagram-UI'
}

{ #category : #'private - updating' }
GtSequenceDiagramElement >> computeElementChildren [
	<return: #GtSequenceDiagramElementChildren>
	| aBuilder |
	aBuilder := GtSequenceDiagramElementChildrenBuilder
			fromSequenceDiagramViewModel: self sequenceDiagramViewModel.
	aBuilder build.

	^ aBuilder specification
]

{ #category : #initialization }
GtSequenceDiagramElement >> initialize [
	super initialize.
	self initializeAsyncElementFuture.

	self fitContent
]

{ #category : #initialization }
GtSequenceDiagramElement >> initializeAsyncElementFuture [
	self
		withAsyncFutureDo: [ :anAsyncElementFuture | 
			anAsyncElementFuture
				whenError: [ :aPreviewElement :anError | 
					self removeChildren.
					self addChild: anError asDebuggableElement fitContent ];
				whenSuccess: [ :aPreviewElement :aSpecification | self updateElementWithSpecification: aSpecification ] ]
]

{ #category : #'private - announcement handling' }
GtSequenceDiagramElement >> onSequenceDiagramChanged: anAnnouncement [
	self requestElementUpdate
]

{ #category : #'api - sequence diagram view model' }
GtSequenceDiagramElement >> onSequenceDiagramViewModelChanged [
	self requestElementUpdate
]

{ #category : #'private - updating' }
GtSequenceDiagramElement >> requestElementUpdate [
	self
		withAsyncFutureDo: [ :anAsyncElementFuture | anAsyncElementFuture future: [ self computeElementChildren ] ]
]

{ #category : #'api - sequence diagram view model' }
GtSequenceDiagramElement >> subscribeToSequenceDiagramViewModel [
	self sequenceDiagramViewModel weak
		when: GtSequenceDiagramChangedAnnouncement
		send: #onSequenceDiagramChanged:
		to: self
]

{ #category : #'api - sequence diagram view model' }
GtSequenceDiagramElement >> unsubscribeFromSequenceDiagramViewModel [
	self sequenceDiagramViewModel unsubscribe: self
]

{ #category : #'private - updating' }
GtSequenceDiagramElement >> updateElementWithSpecification: aSpecification [
	self removeChildren.
	self columnCount: aSpecification numberOfParticipants.
	self addChildren: aSpecification participantHeaderElements.

	aSpecification messageChildren
		do: [ :aMessageChild | self addChildren: aMessageChild nodeElements ].

	aSpecification messageChildren
		do: [ :aMessageChild | aMessageChild edgeElement ifNotNil: [ :anElement | self addChild: anElement ] ]
]
