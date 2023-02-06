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
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ labelModel = anObject labelModel
		and: [ id = anObject id
			and: [ size = anObject size
				and: [ coordinate = anObject coordinate
					and: [ color = anObject color ] ] ] ]
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
		assert: [ aNodeModel parent == self parent ]
		description: [ 'Pipeline node and its inner node must has the same parent: {1}, {2}'
				format: {self parent.
						aNodeModel parent} ].

	aNodeModel removeFromPipeline.
	aNodeModel pipelineNode: self.

	self innerNodes: (self innerNodes copyWith: aNodeModel)
]

{ #category : #announcer }
GtWardleyMapNodeModel >> announcer [
	<return: #Announcer>
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> ensurePipelineCoordinate [
	pipelineCoordinate ifNotNil: [ ^ self ].

	pipelineCoordinate := (self coordinate x - 0.2 max: 0.0)
			@ (self coordinate x + 0.2 min: 1.0)
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

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> hasPipelineCoordinates [
	"True means that a pipeline was already computed at some point.
	It implies that they must be kept in sync with node coordinates."

	<return: #Boolean>
	^ pipelineCoordinate isNotNil
]

{ #category : #comparing }
GtWardleyMapNodeModel >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ labelModel hash bitXor: id hash
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
	
	color := Color black.
	coordinate := 0.5@0.5.
	size := 12@12.
	id := nil.
	pipelineCoordinate := nil.
	isPipelineVisible := false.
	innerNodes := #().
	pipelineNode := nil.
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> innerNodes [
	"Return inner nodes that are part of a pipeline"

	<return: #Collection of: #GtWardleyMapNodeModel>
	^ innerNodes
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> innerNodes: aCollectionOfNodes [
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
	^ labelModel
]

{ #category : #initialization }
GtWardleyMapNodeModel >> labelModel: aGtWardleyMapNodeLabelModel [
	labelModel := aGtWardleyMapNodeLabelModel
]

{ #category : #'api - color' }
GtWardleyMapNodeModel >> notifyColored [
	self propagateAnnouncement: (GtWardleyMapNodeModelColored new nodeModel: self)
]

{ #category : #'api - coordinate' }
GtWardleyMapNodeModel >> notifyCoordinateChanged [
	self propagateAnnouncement: (GtWardleyMapNodeModelMoved new nodeModel: self)
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
	self pipelineCoordinate = aPoint ifTrue: [ ^ self ].

	pipelineCoordinate := aPoint.

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
GtWardleyMapNodeModel >> removeInnerNode: aNodeModel [
	"Remove the given node model from my pipeline."

	aNodeModel ifNil: [ ^ self ].
	self isPipelineVisible ifFalse: [ ^ self ].

	aNodeModel pipelineNode: nil.

	self innerNodes: (self innerNodes copyWithout: aNodeModel)
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> removeInnerNodes [
	"Remove all my inner nodes (if any)."

	self innerNodes do: [ :anInnerNode | self removeInnerNode: anInnerNode ]
]
