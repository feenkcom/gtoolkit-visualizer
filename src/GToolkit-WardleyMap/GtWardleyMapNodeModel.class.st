Class {
	#name : #GtWardleyMapNodeModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TGtWardleyMapWithParent + TGtWardleyMapWithCoordinate + TGtWardleyMapWithColor + TGtWardleyMapWithSize + TGtWardleyMapExportable + TGtWardleyMapVisitable + TGtWithWardleyMapDecoratorModels + TGtWithWardleyContextMenuItems',
	#classTraits : 'TGtAnnouncer classTrait + TGtWardleyMapWithParent classTrait + TGtWardleyMapWithCoordinate classTrait + TGtWardleyMapWithColor classTrait + TGtWardleyMapWithSize classTrait + TGtWardleyMapExportable classTrait + TGtWardleyMapVisitable classTrait + TGtWithWardleyMapDecoratorModels classTrait + TGtWithWardleyContextMenuItems classTrait',
	#instVars : [
		'announcer',
		'labelModel',
		'id',
		'pipelineCoordinate',
		'isPipelineVisible',
		'pipelineNode',
		'innerNodes',
		'type',
		'evolveModel',
		'isEvolveVisible'
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
		and: [ self size = anObject size
		and: [ self isEvolveVisible = anObject isEvolveVisible 
		and: [ self evolveModel = anObject evolveModel ] ] ] ] ] ] ] ] ]
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
	aNodeModel == self ifTrue: [ ^ self ].
	aNodeModel isPipelineVisible ifTrue: [ ^ self ].

	self
		assert: [ aNodeModel parent == self parent ]
		description: [ 'Pipeline node and its inner node must have the same parent: {1}, {2}'
				format: {self parent.
						aNodeModel parent} ].
	(self innerNodes identityIncludes: aNodeModel) ifTrue: [ 
		aNodeModel y: self y.
		^ self ].
	
	self prepareInnerNode: aNodeModel.
	self basicInnerNodes: (self innerNodes copyWith: aNodeModel).
	self basicRecomputePipelineCoordinate.
	self notifyInnerNodeAdded: aNodeModel
]

{ #category : #announcer }
GtWardleyMapNodeModel >> announcer [
	<return: #Announcer>
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> basicInnerNodes: aCollectionOfNodes [
	"Set inner nodes that are part of my pipeline.
	Keep in mind to call #pipelineNode: on inner nodes.
	It is preferable to use #addInnerNode: and #removeInnerNode: instead.
	I am used for initialization."

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
GtWardleyMapNodeModel >> basicRecomputePipelineCoordinate [
	"I recompute pipeline coordinate based on the inner nodes coordinate x vales.
	Pipeline left and right coordinates are min and max node x-coordinates.
	I am a private method."
	
	| aCoordinate |
	aCoordinate := GtWardleyMapUtility 
		normalizePipelineWidthOfNodeModel: self
		ignoring: nil.
	
	self pipelineCoordinate: aCoordinate.
]

{ #category : #'api - decorators' }
GtWardleyMapNodeModel >> detectDecorator: aDetectBlock ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self wardleyMapDecoratorModels
		detect: aDetectBlock
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> ensurePipelineCoordinate [
	pipelineCoordinate ifNotNil: [ ^ self ].

	pipelineCoordinate := GtWardleyMapUtility normalizePipelineCoordinate: self coordinate x @ self coordinate x
]

{ #category : #'api - coordinate' }
GtWardleyMapNodeModel >> evolution [
	^ self x
]

{ #category : #'api - coordinate' }
GtWardleyMapNodeModel >> evolution: aNumber [
	self x: aNumber
]

{ #category : #'api - evolve' }
GtWardleyMapNodeModel >> evolveModel [
	<return: #GtWardleyMapNodeEvolveModel>
	^ evolveModel
]

{ #category : #'api - evolve' }
GtWardleyMapNodeModel >> evolveModel: anEvolveModel [
	evolveModel := anEvolveModel.
	anEvolveModel parent: self.
]

{ #category : #'api - evolve' }
GtWardleyMapNodeModel >> evolvedColor [
	^ evolveModel color
]

{ #category : #'api - evolve' }
GtWardleyMapNodeModel >> evolvedColor: aColor [
	evolveModel color: aColor
]

{ #category : #'api - evolve' }
GtWardleyMapNodeModel >> evolvedCoordinate [
	^ evolveModel evolution @ self y
]

{ #category : #'api - evolve' }
GtWardleyMapNodeModel >> evolvedEvolution [
	^ evolveModel evolution
]

{ #category : #'api - evolve' }
GtWardleyMapNodeModel >> evolvedEvolution: aNumber [
	evolveModel evolution: aNumber
]

{ #category : #'api - evolve' }
GtWardleyMapNodeModel >> evolvedLabel [
	^ evolveModel label
]

{ #category : #'api - evolve' }
GtWardleyMapNodeModel >> evolvedLabel: aString [
	evolveModel label: aString
]

{ #category : #'api - evolve' }
GtWardleyMapNodeModel >> evolvedLabelCoordinate [
	^ evolveModel labelCoordinate
]

{ #category : #'api - evolve' }
GtWardleyMapNodeModel >> evolvedLabelCoordinate: aPoint [
	evolveModel labelCoordinate: aPoint
]

{ #category : #'api - evolve' }
GtWardleyMapNodeModel >> evolvedMaturity [
	self
		deprecated: 'Use #evolvedEvolution instead. Check https://swardley.medium.com/map-evolution-not-maturity-bae6ea1a2743'
		transformWith: '`@receiver evolvedMaturity' -> '`@receiver evolvedEvolution'.

	^ self evolvedEvolution
]

{ #category : #'api - evolve' }
GtWardleyMapNodeModel >> evolvedMaturity: aNumber [
	self
		deprecated: 'Please use evolvedEvolution: instead. Check https://swardley.medium.com/map-evolution-not-maturity-bae6ea1a2743'
		transformWith: '`@receiver evolvedMaturity: `@statements1' -> '`@receiver evolvedEvolution: `@statements1'.
	
	self evolvedEvolution: aNumber
]

{ #category : #'api - evolve' }
GtWardleyMapNodeModel >> evolvedSize [
	^ evolveModel size
]

{ #category : #'api - evolve' }
GtWardleyMapNodeModel >> evolvedSize: aPoint [
	evolveModel size: aPoint
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> gtInnerNodesFor: aView [
	<gtView>
	self innerNodes ifNil: [ ^ aView empty ].
	self innerNodes ifEmpty: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'Inner nodes';
		priority: 5;
		items: [ self innerNodes ifNil: [ #() ] ];
		column: 'Index' text: [ :_ :anIndex | anIndex ] width: 40;
		column: 'Color' 
			stencil: [ :aNode |
				BlElement new 
					size: 8@8;
					background: aNode color;
					geometry: BlCircleGeometry new;
					margin: (BlInsets left: 3 right: 3);
					constraintsDo: [ :c | 
						c linear vertical alignCenter ] ] 
			width: 35;
		column: 'Name' text: #label;
		column: 'Has Pipeline' 
			text: [ :aNode | 
				aNode isInnerNode 
					ifTrue: [ (aNode pipelineNode == self)
						ifTrue: [ 'yes' asRopedText foreground: BrGlamorousColors successBackgroundColor ]
						ifFalse: [ ('has {1} pipeline instead of {2}' 
							format: {  aNode pipelineNode. self }) 
								asRopedText foreground: 
									BrGlamorousColors errorBackgroundColor ] ] 
					ifFalse: [ 'pipeline model is missing' asRopedText
						foreground: BrGlamorousColors errorBackgroundColor ] ]
			weight: 2;
		column: 'With pipeline' text: [ :aNode | aNode isPipelineVisible 
			ifTrue: [ 'yes' asRopedText foreground: BrGlamorousColors errorBackgroundColor ] 
			ifFalse: [ 'no' asRopedText foreground: BrGlamorousColors successBackgroundColor ] ];
		column: 'Inner nodes' text: [ :aNode | 
			| aSize |
			aSize := aNode innerNodes size.
			aSize isZero 
				ifTrue: [ aSize asRopedText foreground: BrGlamorousColors successBackgroundColor ]
				ifFalse: [ aSize asRopedText foreground: BrGlamorousColors errorBackgroundColor ] ]
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
		bitXor: (self size hash
		bitXor: (self isEvolveVisible hash
		bitXor: (self evolveModel hash)))))))))
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
	
	evolveModel := GtWardleyMapNodeEvolveModel new.
	evolveModel parent: self.
	isEvolveVisible := false.
	
	color := GtWardleyMapConstants nodeColor.
	coordinate := GtWardleyMapConstants nodeCoordinate.
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
	"Set inner nodes that are part of my pipeline.
	It is preferable to use #addInnerNode: and #removeInnerNode: instead.
	I am used for initialization. I do not notify that nodes were added."

	self 
		assert: [ self innerNodes isEmpty ] 
		description: [ 'I can be used only for initialization' ].
	
	aCollectionOfNodes do: [ :eachInnerNode | 
		self prepareInnerNode: eachInnerNode  ].
	self basicInnerNodes: aCollectionOfNodes.
	self basicRecomputePipelineCoordinate.
]

{ #category : #'api - evolve' }
GtWardleyMapNodeModel >> isEvolveVisible [
	"True means that an evolve node should be displayed, false otherwise"

	<return: #Boolean>
	^ isEvolveVisible
]

{ #category : #'api - evolve' }
GtWardleyMapNodeModel >> isEvolveVisible: aBoolean [
	self isEvolveVisible = aBoolean ifTrue: [ ^ self ].

	isEvolveVisible := aBoolean.
	
	self notifyEvolveVisibityChanged
]

{ #category : #'api - evolve' }
GtWardleyMapNodeModel >> isEvolvedLabelVisible [
	^ evolveModel isLabelVisible
]

{ #category : #'api - evolve' }
GtWardleyMapNodeModel >> isEvolvedLabelVisible: aBoolean [
	evolveModel isLabelVisible: aBoolean
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> isInnerNode [
	<return: #Boolean>
	^ self pipelineNode isNotNil
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
	labelModel := aGtWardleyMapNodeLabelModel.
	aGtWardleyMapNodeLabelModel parent: self
]

{ #category : #'api - coordinate' }
GtWardleyMapNodeModel >> maturity [
	self
		deprecated: 'Use #evolution instead. Check https://swardley.medium.com/map-evolution-not-maturity-bae6ea1a2743'
		transformWith: '`@receiver maturity' -> '`@receiver evolution'.
	
	^ self evolution
]

{ #category : #'api - coordinate' }
GtWardleyMapNodeModel >> maturity: aNumber [
	self
		deprecated: 'Please use evolution: instead. Check https://swardley.medium.com/map-evolution-not-maturity-bae6ea1a2743'
		transformWith: '`@receiver maturity: `@statements1' -> '`@receiver evolution: `@statements1'.
	
	self evolution: aNumber
]

{ #category : #'api - context menu' }
GtWardleyMapNodeModel >> menuItemNodeAddEvolveButton [
	<wardleyContextMenuItem: 7>
	^ GtWardleyMapNodeAddEvolveMenuItem new
]

{ #category : #'api - context menu' }
GtWardleyMapNodeModel >> menuItemNodeColorLabel [
	<wardleyContextMenuItem: 1>
	^ GtWardleyMapLabelMenuItem new text: 'Node color:'
]

{ #category : #'api - context menu' }
GtWardleyMapNodeModel >> menuItemNodeColorPicker [
	<wardleyContextMenuItem: 2>
	^ GtWardleyMapColorPickerMenuItem new
]

{ #category : #'api - context menu' }
GtWardleyMapNodeModel >> menuItemNodeDangerZoneLabel [
	<wardleyContextMenuItem: 500>
	^ GtWardleyMapLabelMenuItem new text: 'Danger zone:'
]

{ #category : #'api - context menu' }
GtWardleyMapNodeModel >> menuItemNodeDeleteButton [
	<wardleyContextMenuItem: 550>
	^ GtWardleyMapNodeDeleteMenuItem new
]

{ #category : #'api - context menu' }
GtWardleyMapNodeModel >> menuItemNodePipelineLabel [
	<wardleyContextMenuItem: 5>
	^ GtWardleyMapLabelMenuItem new text: 'Pipeline:'
]

{ #category : #'api - context menu' }
GtWardleyMapNodeModel >> menuItemNodePipelineVisibilityPicker [
	<wardleyContextMenuItem: 6>
	^ GtWardleyMapNodePipelineVisiblityMenuItem new
]

{ #category : #'api - context menu' }
GtWardleyMapNodeModel >> menuItemNodeSizeLabel [
	<wardleyContextMenuItem: 3>
	^ GtWardleyMapLabelMenuItem new text: 'Node size:'
]

{ #category : #'api - context menu' }
GtWardleyMapNodeModel >> menuItemNodeSizePicker [
	<wardleyContextMenuItem: 4>
	^ GtWardleyMapNodeSizePickerMenuItem new
]

{ #category : #'api - color' }
GtWardleyMapNodeModel >> notifyColored [
	self propagateAnnouncement: (GtWardleyMapNodeModelColored new nodeModel: self)
]

{ #category : #'api - coordinate' }
GtWardleyMapNodeModel >> notifyCoordinateChanged [
	self propagateAnnouncement: (GtWardleyMapNodeModelMoved new nodeModel: self)
]

{ #category : #'api - evolve' }
GtWardleyMapNodeModel >> notifyEvolveVisibityChanged [
	self
		propagateAnnouncement: (GtWardleyMapNodeModelEvolveVisibilityChanged new nodeModel: self)
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

	"Allow a smaller pipeline if there are inner nodes."
	aNormalizedCoordinate := aPoint.
	self innerNodes ifEmpty: [
		aNormalizedCoordinate := GtWardleyMapUtility normalizePipelineCoordinate: aPoint.
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

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> prepareInnerNode: aNodeModel [
	"I prepare a node to be added as my inner node"

	aNodeModel isPipelineVisible: false.
	aNodeModel removeFromPipeline.
	aNodeModel pipelineNode: self.
	
	"Our model assumes that inners nodes has same vertical value as the pipeline node.
	Doing so, we can easily locate inner node widgets always inside of the pipeline widgets
	while using relative (0,1) coordinates."
	aNodeModel y: self y
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

{ #category : #'api - node' }
GtWardleyMapNodeModel >> removeFromMap [
	parent ifNotNil: [ :aParent | parent removeNode: self ]
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
	
	(self innerNodes identityIncludes: anInnerNodeModel) ifFalse: [ ^ self ].

	anInnerNodeModel pipelineNode: nil.

	self basicInnerNodes: (self innerNodes copyWithout: anInnerNodeModel).
	
	self basicRecomputePipelineCoordinate.
	
	self notifyInnerNodeRemoved: anInnerNodeModel
]

{ #category : #'api - pipeline' }
GtWardleyMapNodeModel >> removeInnerNodes [
	"Remove all my inner nodes (if any)."

	self innerNodes do: [ :anInnerNode | self removeInnerNode: anInnerNode ]
]

{ #category : #'api - coordinate' }
GtWardleyMapNodeModel >> visibility [
	^ 1 - self y
]

{ #category : #'api - coordinate' }
GtWardleyMapNodeModel >> visibility: aNumber [
	self y: 1 - aNumber
]
