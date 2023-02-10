Class {
	#name : #GtWardleyMapNodeViewModel,
	#superclass : #Object,
	#traits : 'TGtWithWardleyMapNodeModel + TGtAnnouncer',
	#classTraits : 'TGtWithWardleyMapNodeModel classTrait + TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'wardleyMapViewModel',
		'innerNodeViewModels',
		'pipelineNodeViewModel'
	],
	#category : #'GToolkit-WardleyMap-! View models'
}

{ #category : #'api - pipeline' }
GtWardleyMapNodeViewModel >> addInnerNodeViewModel: aNodeViewModel [
	"Let the node model be part of my pipeline."
	
	aNodeViewModel ifNil: [ ^ self ].
	self isPipelineVisible ifFalse: [ ^ self ].
	self == aNodeViewModel ifTrue: [ ^ self ].
	aNodeViewModel isPipelineVisible ifTrue: [ ^ self ].
	
	self wardleyMapNodeModel addInnerNode: aNodeViewModel wardleyMapNodeModel.
]

{ #category : #announcer }
GtWardleyMapNodeViewModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'api - node' }
GtWardleyMapNodeViewModel >> changeColorTo: aColor [
	self wardleyMapNodeModel color: aColor
]

{ #category : #'api - accessing' }
GtWardleyMapNodeViewModel >> coordinate [
	^ self wardleyMapNodeModel coordinate
]

{ #category : #'api - accessing' }
GtWardleyMapNodeViewModel >> coordinateX [
	<return: #Point>

	^ self coordinate x
]

{ #category : #'api - accessing' }
GtWardleyMapNodeViewModel >> coordinateY [
	<return: #Number>

	^ self coordinate y
]

{ #category : #'api - node' }
GtWardleyMapNodeViewModel >> decreaseNodeSize [
	self nodeSize: ((self nodeSize - self nodeSizeStep) roundTo: 1@1)
]

{ #category : #'api - node' }
GtWardleyMapNodeViewModel >> increaseNodeSize [
	self nodeSize: ((self nodeSize + self nodeSizeStep) roundTo: 1@1)
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeViewModel >> innerNodeViewModels [
	<return: #Collection of: #GtWardleyMapNodeViewModel>
	^ innerNodeViewModels ifNil: [ #() ]
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeViewModel >> innerNodeViewModels: aNodeViewModels [
	"set view models of my inner nodes"

	innerNodeViewModels := aNodeViewModels
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeViewModel >> isPipelineVisible [
	^ self wardleyMapNodeModel isPipelineVisible
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeViewModel >> isPipelineVisible: aBoolean [
	self wardleyMapNodeModel isPipelineVisible: aBoolean
]

{ #category : #'api - accessing' }
GtWardleyMapNodeViewModel >> label [
	^ self wardleyMapNodeModel label
]

{ #category : #'api - accessing' }
GtWardleyMapNodeViewModel >> label: aString [
	self wardleyMapNodeModel label: aString
]

{ #category : #'api - accessing' }
GtWardleyMapNodeViewModel >> labelColor [
	^ self nodeColor darker
]

{ #category : #'api - accessing' }
GtWardleyMapNodeViewModel >> labelCoordinate [
	^ self wardleyMapNodeModel labelModel coordinate
]

{ #category : #'api - accessing' }
GtWardleyMapNodeViewModel >> labelCoordinateX [
	^ self labelCoordinate x
]

{ #category : #'api - accessing' }
GtWardleyMapNodeViewModel >> labelCoordinateY [
	^ self labelCoordinate y
]

{ #category : #'api - node' }
GtWardleyMapNodeViewModel >> moveNodeLabelTo: aNormalizedPoint [
	self wardleyMapNodeModel labelModel coordinate: aNormalizedPoint
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeViewModel >> moveNodePipelineTo: aNormalizedPoint [
	"aNormalizedPoint is a position (x, y) of the pipeline.
	We need to adjust the pipeline coordinate to (oldLeft+diffX, oldRight+diffX)
	We need to move the node coordinate too by (oldX + diff, aNormalizedPoint y)"
	| aCurrentPipelineCoordinate aDiffX aNewPipelineCoordinate aNewNodeCoordinate aDiffY aCurrentNodeCoordinate aDiff |
	
	self isPipelineVisible ifFalse: [ ^ self ].
	
	"Let's compute the pipeline diff to move it properly"
	aCurrentPipelineCoordinate := self wardleyMapNodeModel pipelineCoordinate.
	aDiffX := aNormalizedPoint x - aCurrentPipelineCoordinate x.
	aNewPipelineCoordinate := aCurrentPipelineCoordinate + (aDiffX @ aDiffX).
	
	"Let's compute node normalized point to move it properly"
	aCurrentNodeCoordinate := self wardleyMapNodeModel coordinate.
	aDiffY := aNormalizedPoint y - aCurrentNodeCoordinate y.
	aDiff := aDiffX @ aDiffY.
	aNewNodeCoordinate := aCurrentNodeCoordinate + aDiff.
	
	self wardleyMapNodeModel coordinate: aNewNodeCoordinate.
	self wardleyMapNodeModel pipelineCoordinate: aNewPipelineCoordinate.
	
	"Let's move inner nodes"
	self innerNodeViewModels do: [ :eachInnerNode |
		eachInnerNode moveNodeTo: eachInnerNode coordinate + aDiff ]
]

{ #category : #'api - node' }
GtWardleyMapNodeViewModel >> moveNodeTo: aNormalizedPoint [
	"If a pipeline is visible, we keep the node inside of the pipeline width"

	| aCorrectedPoint |
	aCorrectedPoint := self isPipelineVisible
			ifTrue: [ | aPipelineCoordinate aCorrectedX aNodeCoordinate |
				aPipelineCoordinate := self wardleyMapNodeModel pipelineCoordinate.
				aNodeCoordinate := self wardleyMapNodeModel coordinate.
				aCorrectedX := (aPipelineCoordinate x max: aNormalizedPoint x)
						min: aPipelineCoordinate y.
				aCorrectedX @ aNodeCoordinate y ]
			ifFalse: [ aNormalizedPoint ].

	self wardleyMapNodeModel coordinate: aCorrectedPoint
]

{ #category : #'api - accessing' }
GtWardleyMapNodeViewModel >> nodeColor [
	^ self wardleyMapNodeModel color
]

{ #category : #'api - accessing' }
GtWardleyMapNodeViewModel >> nodeSize [
	^ self wardleyMapNodeModel size
]

{ #category : #'api - accessing' }
GtWardleyMapNodeViewModel >> nodeSize: aPoint [
	self wardleyMapNodeModel size: (aPoint max: 1@1)
]

{ #category : #'api - node' }
GtWardleyMapNodeViewModel >> nodeSizeStep [
	^ ((self nodeSize min // 10 + 1) max: 1) asPoint / 2.0
]

{ #category : #'event handling' }
GtWardleyMapNodeViewModel >> onNodeColored: anAnnouncement [
	self announce: (GtWardleyMapNodeViewModelColored new nodeViewModel: self)
]

{ #category : #'event handling' }
GtWardleyMapNodeViewModel >> onNodeLabelMoved: anAnnouncement [
	self announce: (GtWardleyMapNodeViewModelLabelMoved new nodeViewModel: self)
]

{ #category : #'event handling' }
GtWardleyMapNodeViewModel >> onNodeLabelTextChanged: anAnnouncement [
	self announce: (GtWardleyMapNodeViewModelLabelTextChanged new nodeViewModel: self)
]

{ #category : #'event handling' }
GtWardleyMapNodeViewModel >> onNodeMoved: anAnnouncement [
	self announce: (GtWardleyMapNodeViewModelMoved new nodeViewModel: self).
	self wardleyMapViewModel announce: (GtWardleyMapNodeViewModelMoved new nodeViewModel: self)
]

{ #category : #'event handling' }
GtWardleyMapNodeViewModel >> onNodePipelineResized: anAnnouncement [
	self
		announce: (GtWardleyMapNodeViewModelPipelineResized new nodeViewModel: self)
]

{ #category : #'event handling' }
GtWardleyMapNodeViewModel >> onNodePipelineVisibilityChanged: anAnnouncement [
	self announce: (GtWardleyMapNodeViewModelPipelineVisibilityChanged new nodeViewModel: self)
]

{ #category : #'event handling' }
GtWardleyMapNodeViewModel >> onNodeResized: anAnnouncement [
	self announce: (GtWardleyMapNodeViewModelResized new nodeViewModel: self)
]

{ #category : #'api - wardley map node model' }
GtWardleyMapNodeViewModel >> onWardleyMapNodeModelChanged [
	"Is sent when a new wardleyMapNode model is assigned to the view model"
	
	
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeViewModel >> pipelineColor [
	^ self wardleyMapNodeModel color
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeViewModel >> pipelineCoordinate [
	<return: #Number>
	^ self wardleyMapNodeModel pipelineCoordinate
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeViewModel >> pipelineCoordinate: aPipelineCoordinate [
	self wardleyMapNodeModel pipelineCoordinate: aPipelineCoordinate
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeViewModel >> pipelineCoordinateLeft [
	<return: #Number>
	^ self pipelineCoordinate x
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeViewModel >> pipelineCoordinateRight [
	<return: #Number>
	^ self pipelineCoordinate y
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeViewModel >> pipelineCoordinateTop [
	<return: #Number>
	^ self coordinate y
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeViewModel >> pipelineCoordinateWeight [
	<return: #Number>
	^ self pipelineCoordinate y - self pipelineCoordinate x
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeViewModel >> pipelineNodeViewModel [
	<return: #GtWardleyMapNodeViewModel or: nil>
	^ pipelineNodeViewModel
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeViewModel >> pipelineNodeViewModel: aPipelineNodeViewModel [
	"Set my pipeline node view model"

	pipelineNodeViewModel := aPipelineNodeViewModel
]

{ #category : #accessing }
GtWardleyMapNodeViewModel >> printOn: aStream [
	super printOn: aStream.

	self hasWardleyMapNode ifFalse: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: self label asString;
		nextPut: $)
]

{ #category : #'api - node' }
GtWardleyMapNodeViewModel >> removeFromMap [
	self wardleyMapViewModel removeNodeViewModel: self
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeViewModel >> removeInnerNodeViewModel: anInnerNodeViewModel [
	self wardleyMapNodeModel removeInnerNode: anInnerNodeViewModel wardleyMapNodeModel
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeViewModel >> snapInnerNodeViewModel: anInnerNodeViewModel [
	anInnerNodeViewModel wardleyMapNodeModel y: self coordinateY
]

{ #category : #'api - wardley map node model' }
GtWardleyMapNodeViewModel >> subscribeToWardleyMapNodeModel [
	"Is sent after a new wardleyMapNode model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromWardleyMapNodeModel if view model subscribes to them"
	
	self wardleyMapNodeModel weak
		when: GtWardleyMapNodeModelMoved send: #onNodeMoved: to: self;
		when: GtWardleyMapNodeModelColored send: #onNodeColored: to: self;
		when: GtWardleyMapNodeModelResized send: #onNodeResized: to: self;
		when: GtWardleyMapNodeModelPipelineVisibilityChanged send: #onNodePipelineVisibilityChanged: to: self;
		when: GtWardleyMapNodeModelPipelineResized send: #onNodePipelineResized: to: self.
	
	self wardleyMapNodeModel labelModel weak
		when: GtWardleyMapNodeLabelModelMoved send: #onNodeLabelMoved: to: self;
		when: GtWardleyMapNodeLabelModelTextChanged send: #onNodeLabelTextChanged: to: self
]

{ #category : #'api - wardley map node model' }
GtWardleyMapNodeViewModel >> unsubscribeFromWardleyMapNodeModel [
	"Is sent before a new wardleyMapNode model is assigned to the view model.
	View models that subscribe to wardleyMapNode model are required to implement this methods"

	self wardleyMapNodeModel unsubscribe: self.
	self wardleyMapNodeModel labelModel unsubscribe: self
]

{ #category : #'api - accessing' }
GtWardleyMapNodeViewModel >> wardleyMapViewModel [
	^ wardleyMapViewModel
]

{ #category : #'api - accessing' }
GtWardleyMapNodeViewModel >> wardleyMapViewModel: aMapViewModel [
	wardleyMapViewModel := aMapViewModel
]
