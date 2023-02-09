Class {
	#name : #GtWardleyMapNodeModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TGtWardleyMapWithParent + TGtWardleyMapWithCoordinate + TGtWardleyMapWithColor + TGtWardleyMapWithSize + TGtWardleyMapExportable + TGtWardleyMapVisitable',
	#classTraits : 'TGtAnnouncer classTrait + TGtWardleyMapWithParent classTrait + TGtWardleyMapWithCoordinate classTrait + TGtWardleyMapWithColor classTrait + TGtWardleyMapWithSize classTrait + TGtWardleyMapExportable classTrait + TGtWardleyMapVisitable classTrait',
	#instVars : [
		'announcer',
		'labelModel',
		'id',
		'pipelineCoordinate',
		'isPipelineVisible',
		'pipelineNode',
		'innerNodes'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #comparing }
GtWardleyMapNodeModel >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].

	self class = anObject class
		ifFalse: [ ^ false ].

	^ self color = anObject color
		and: [ self coordinate = anObject coordinate
			and: [ self id = anObject id
				and: [ self innerNodes = anObject innerNodes
					and: [ self isPipelineVisible = anObject isPipelineVisible
						and: [ self labelModel = anObject labelModel
							and: [ self pipelineCoordinate = anObject pipelineCoordinate
								and: [ self size = anObject size ] ] ] ] ] ] ]
]

{ #category : #visiting }
GtWardleyMapNodeModel >> accept: aWardleyMapVisitor [
	^ aWardleyMapVisitor visitWardleyMapNode: self
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> addInnerNode: aNodeModel [
	"Let the node model be part of my pipeline."

	aNodeModel ifNil: [ ^ self ].
	self isPipelineVisible ifFalse: [ ^ self ].
	self
		assert: [ (aNodeModel == self) not ]
		description: [ 'Cannot add inner node into itself: {1}' format: {self} ].

	self
		assert: [ aNodeModel parent == self parent ]
		description: [ 'Pipeline node and its inner node must has the same parent: {1}, {2}'
				format: {self parent.
						aNodeModel parent} ].

	aNodeModel removeFromPipeline.
	aNodeModel pipelineNode: self.

	self innerNodes: (self innerNodes copyWith: aNodeModel).

	self notifyInnerNodeAdded: aNodeModel
]

{ #category : #announcer }
GtWardleyMapNodeModel >> announcer [
	<return: #Announcer>
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> ensurePipelineCoordinate [
	pipelineCoordinate ifNotNil: [ ^ self ].

	pipelineCoordinate := self normalizePipelineCoordinate: self coordinate x @ self coordinate x
]

{ #category : #'api - export / import' }
GtWardleyMapNodeModel >> gtJSONFor: aView [
	<gtView>

	^ aView textEditor
		title: 'JSON';
		priority: 8;
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		styler: [ JSONParser gtStyler ];
		text: [ self asJSONForExport ];
		actionButtonLabel: 'Copy'
			action: [ Clipboard clipboardText: self asJSONForExport ]
]

{ #category : #testing }
GtWardleyMapNodeModel >> hasId [
	^ id notNil
]

{ #category : #comparing }
GtWardleyMapNodeModel >> hash [
	^ self color hash
		bitXor: (self coordinate hash
			bitXor: (self id hash
				bitXor: (self innerNodes hash
					bitXor: (self isPipelineVisible hash
						bitXor: (self labelModel hash
							bitXor: (self pipelineCoordinate hash
								bitXor: (self size hash)))))))
]

{ #category : #accessing }
GtWardleyMapNodeModel >> id [
	^ id
]

{ #category : #accessing }
GtWardleyMapNodeModel >> id: anObject [
	id := anObject
]

{ #category : #initialization }
GtWardleyMapNodeModel >> initialize [
	super initialize.

	labelModel := GtWardleyMapNodeLabelModel new.
	labelModel parent: self.
	
	color := GtWardleyMapConstants nodeColor.
	coordinate := 0.5@0.5.
	size := GtWardleyMapConstants nodeSize.
	id := nil.
	pipelineCoordinate := nil.
	isPipelineVisible := false.
	innerNodes := #().
	pipelineNode := nil.
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> innerNodes [
	"Return inner nodes that are part of my pipeline"

	<return: #Collection of: #GtWardleyMapNodeModel>
	^ innerNodes
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> innerNodes: aCollectionOfNodes [
	"Set inner nodes that are part of my pipeline"

	self
		assert: [ self isPipelineVisible ]
		description: [ 'Pipeline must be visible then inner nodes can be set' ].

	aCollectionOfNodes do: [ :eachInnerNode | 
		self 
			assert: [ eachInnerNode isPipelineVisible not ] 
			description: [ 'Inner nodes must be without pipeline, but {1} has pipeline visible.' 
				format: { eachInnerNode label } ] ].

	innerNodes := aCollectionOfNodes
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> isPipelineVisible [
	"True means that a pipeline should be displayed, false otherwise"

	<return: #Boolean>
	^ isPipelineVisible
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> isPipelineVisible: aBoolean [
	self isPipelineVisible = aBoolean ifTrue: [ ^ self ].

	aBoolean ifFalse: [ 
		self removeInnerNodes.
		pipelineCoordinate := nil ].

	isPipelineVisible := aBoolean.
	
	self notifyPipelineVisibityChanged
]

{ #category : #accessing }
GtWardleyMapNodeModel >> label [
	<return: #String>

	^ self labelModel label
]

{ #category : #accessing }
GtWardleyMapNodeModel >> label: aString [
	self labelModel label: aString
]

{ #category : #accessing }
GtWardleyMapNodeModel >> labelModel [
	<return: #GtWardleyMapNodeLabelModel>
	^ labelModel
]

{ #category : #initialization }
GtWardleyMapNodeModel >> labelModel: aGtWardleyMapNodeLabelModel [
	labelModel := aGtWardleyMapNodeLabelModel
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> normalizePipelineCoordinate: aPoint [ 
	"I ensure a minimum pipeline width"
	
	| aWidth anIncrease aLeft aRight |
	aWidth := aPoint y - aPoint x.
	aWidth >= GtWardleyMapConstants minPipelineRelativeWidth ifTrue: [ ^ aPoint ].
	
	anIncrease := GtWardleyMapConstants minPipelineRelativeWidth - aWidth.
		
	aLeft := aPoint x - (anIncrease / 2).
	aRight := aPoint y + (anIncrease / 2).
	aLeft < 0 ifTrue: [
		aRight := (aRight - aLeft) min: 1.0.
		aLeft := 0 ].
	aRight > 1 ifTrue: [ 
		aLeft := aLeft - (aRight - 1.0) max: 0.0.
		aRight := 1.0
	].
	
	^ aLeft @ aRight
]

{ #category : #'api - color' }
GtWardleyMapNodeModel >> notifyColored [
	self propagateAnnouncement: (GtWardleyMapNodeModelColored new nodeModel: self)
]

{ #category : #'api - coordinate' }
GtWardleyMapNodeModel >> notifyCoordinateChanged [
	self propagateAnnouncement: (GtWardleyMapNodeModelMoved new nodeModel: self)
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> notifyInnerNodeAdded: anInnerNodeModel [
	self
		propagateAnnouncement: (GtWardleyMapNodeModelInnerNodeAdded new
				nodeModel: self;
				innerNodeModel: anInnerNodeModel)
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> notifyInnerNodeRemoved: anInnerNodeModel [
	self
		propagateAnnouncement: (GtWardleyMapNodeModelInnerNodeRemoved new
				nodeModel: self;
				innerNodeModel: anInnerNodeModel)
]

{ #category : #'api - parent' }
GtWardleyMapNodeModel >> notifyParentChanged [
	
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> notifyPipelineCoordinateChanged [
	self
		propagateAnnouncement: (GtWardleyMapNodeModelPipelineResized new nodeModel: self)
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> notifyPipelineVisibityChanged [
	self
		propagateAnnouncement: (GtWardleyMapNodeModelPipelineVisibilityChanged new nodeModel: self)
]

{ #category : #'api - size' }
GtWardleyMapNodeModel >> notifySizeChanged [
	self propagateAnnouncement: (GtWardleyMapNodeModelResized new nodeModel: self)
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> pipelineCoordinate [
	"Return a pipeline left and right side positions.
	X is left relative position value.
	Y is right relative position value.
	Both values are between 0 and 1.
	X < Y"
	<return: #Point>
	self ensurePipelineCoordinate.
	
	^ pipelineCoordinate
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> pipelineCoordinate: aPoint [
	| aNormalizedCoordinate |
	self pipelineCoordinate = aPoint ifTrue: [ ^ self ].

	aNormalizedCoordinate := aPoint.
	self innerNodes ifEmpty: [
		aNormalizedCoordinate := self normalizePipelineCoordinate: aPoint.
		self pipelineCoordinate = aNormalizedCoordinate ifTrue: [ ^ self ] ].
	
	pipelineCoordinate := aNormalizedCoordinate.

	self notifyPipelineCoordinateChanged
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> pipelineNode [
	"Return a pipeline node that I am part of"

	<return: #GtWardleyMapNodeModel or: nil>
	^ pipelineNode
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> pipelineNode: aNodeModel [
	"Set a pipeline node that I am part of"

	self
		assert: [ pipelineNode isNil or: [ aNodeModel isNil ] ]
		description: [ 'I can be part of one pipeline node only, current pipeline node: {1}, new pipeline: {2} '
				format: {self pipelineNode.
						aNodeModel} ].
	
	self
		assert: [ self isPipelineVisible not ]
		description: [ 'Inner nodes must have hidden pipeline.' ].

	pipelineNode := aNodeModel
]

{ #category : #printing }
GtWardleyMapNodeModel >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	aStream
		nextPutAll: 'Node {';
		nextPutAll: ' label: ';
		print: self label;
		nextPutAll: '; coordinate: ';
		print: self coordinate;
		nextPutAll: '; size: ';
		print: self size;
		nextPutAll: '; color: ';
		print: self color;
		nextPutAll: '; id: ';
		print: id;
		nextPutAll: ' }'
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> removeFromPipeline [
	"Remove myself from a pipeline node."

	self pipelineNode
		ifNotNil: [ :aPipelinenNode | aPipelinenNode removeInnerNode: self ]
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> removeInnerNode: anInnerNodeModel [
	"Remove the given node model from my pipeline."

	anInnerNodeModel ifNil: [ ^ self ].

	anInnerNodeModel pipelineNode: nil.

	self innerNodes: (self innerNodes copyWithout: anInnerNodeModel).
	
	self innerNodes ifEmpty: [ 
		self pipelineCoordinate: (self normalizePipelineCoordinate: self pipelineCoordinate)
	].
	
	self notifyInnerNodeRemoved: anInnerNodeModel
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> removeInnerNodes [
	"Remove all my inner nodes (if any)."

	self innerNodes do: [ :anInnerNode | self removeInnerNode: anInnerNode ]
]
