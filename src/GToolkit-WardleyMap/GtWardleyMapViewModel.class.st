Class {
	#name : #GtWardleyMapViewModel,
	#superclass : #Object,
	#traits : 'TGtWithWardleyMapModel + TGtAnnouncer',
	#classTraits : 'TGtWithWardleyMapModel classTrait + TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'nodeViewModels',
		'edgeViewModels',
		'predefinedColors',
		'defaultColor'
	],
	#category : #'GToolkit-WardleyMap-! View models'
}

{ #category : #'api - map' }
GtWardleyMapViewModel >> addNewEdgeFrom: aFromNodeViewModel to: aToNodeViewModel [
	| aNewEdge |
	
	aNewEdge := GtWardleyMapEdgeModel new
		fromNode: aFromNodeViewModel wardleyMapNodeModel;
		toNode: aToNodeViewModel wardleyMapNodeModel;
		color: aFromNodeViewModel nodeColor.
		
	self wardleyMapModel addEdge: aNewEdge
]

{ #category : #'api - map' }
GtWardleyMapViewModel >> addNewNodeAt: aNormalizedPosition [
	| aNewNode |
	
	aNewNode := GtWardleyMapNodeModel new
		coordinate: aNormalizedPosition;
		color: self defaultColor.
		
	self wardleyMapModel addNode: aNewNode
]

{ #category : #announcer }
GtWardleyMapViewModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #initialization }
GtWardleyMapViewModel >> createEdgeViewModelFor: anEdgeModel [
	^ GtWardleyMapEdgeViewModel new
		wardleyMapViewModel: self;
		wardleyMapEdgeModel: anEdgeModel
]

{ #category : #initialization }
GtWardleyMapViewModel >> createNodeViewModelFor: aNodeModel [
	^ GtWardleyMapNodeViewModel new
		wardleyMapViewModel: self;
		wardleyMapNodeModel: aNodeModel
]

{ #category : #accessing }
GtWardleyMapViewModel >> defaultColor [
	^ defaultColor
]

{ #category : #accessing }
GtWardleyMapViewModel >> defaultColor: aColor [
	defaultColor := aColor
]

{ #category : #'api - map' }
GtWardleyMapViewModel >> edgeViewModelFor: anEdgeModel ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self edgeViewModels
		detect: [ :eachEdgeViewModel | eachEdgeViewModel wardleyMapEdgeModel = anEdgeModel ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #accessing }
GtWardleyMapViewModel >> edgeViewModels [
	^ edgeViewModels
]

{ #category : #accessing }
GtWardleyMapViewModel >> edgeViewModels: anObject [
	edgeViewModels := anObject
]

{ #category : #'gt - extensions' }
GtWardleyMapViewModel >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		priority: 2;
		stencil: [ GtWardleyMapElement new
				wardleyMapViewModel: self;
				yourself ]
]

{ #category : #initialization }
GtWardleyMapViewModel >> initialize [
	super initialize.
	
	nodeViewModels := OrderedCollection new.
	edgeViewModels := OrderedCollection new.
	
	predefinedColors := { 
		Color black.
		Color veryVeryDarkGray.
		Color veryDarkGray.
		Color darkGray.
		Color gray.
		Color lightGray.
		Color veryLightGray.
		Color veryVeryLightGray.
		Color red muchDarker.
		Color red darker.
		Color red.
		Color red lighter.
		Color red muchLighter.
	}.
	
	defaultColor := GtWardleyMapConstants nodeColor
]

{ #category : #'api - map' }
GtWardleyMapViewModel >> nodeViewModelFor: aNodeModel ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self nodeViewModels
		detect: [ :eachNodeViewModel | eachNodeViewModel wardleyMapNodeModel = aNodeModel ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #accessing }
GtWardleyMapViewModel >> nodeViewModels [
	<return: #Collection of: #GtWardleyMapNodeViewModel>

	^ nodeViewModels
]

{ #category : #'event handling' }
GtWardleyMapViewModel >> onEdgeAdded: anAnnouncement [
	| anEdgeViewModel |
	edgeViewModels add: (anEdgeViewModel := self createEdgeViewModelFor: anAnnouncement edgeModel).
	self announce: (GtWardleyMapEdgeViewModelAdded new edgeViewModel: anEdgeViewModel)
]

{ #category : #'event handling' }
GtWardleyMapViewModel >> onEdgeRemoved: anAnnouncement [
	self 
		edgeViewModelFor: anAnnouncement edgeModel
		ifFound: [ :anEdgeViewModel |
			edgeViewModels remove: anEdgeViewModel.
			self announce: (GtWardleyMapEdgeViewModelRemoved new edgeViewModel: anEdgeViewModel) ]
		ifNone: [ ]
]

{ #category : #'event handling' }
GtWardleyMapViewModel >> onInnerNodeAdded: anAnnouncement [
	self
		nodeViewModelFor: anAnnouncement nodeModel
		ifFound: [ :aPipelineViewNode | 
			self
				nodeViewModelFor: anAnnouncement innerNodeModel
				ifFound: [ :anInnerNodeViewNode | 
					aPipelineViewNode == anInnerNodeViewNode
						ifFalse: [ 
							aPipelineViewNode innerNodeViewModels: (
								aPipelineViewNode innerNodeViewModels copyWith: anInnerNodeViewNode).
							anInnerNodeViewNode pipelineNodeViewModel: aPipelineViewNode.
							self announce: (GtWardleyMapNodeViewModelInnerNodeAdded new 
								pipelineViewModel: aPipelineViewNode;
								innerNodeViewModel: anInnerNodeViewNode ) ] ]
				ifNone: [  ] ]
		ifNone: [  ]
]

{ #category : #'event handling' }
GtWardleyMapViewModel >> onInnerNodeRemoved: anAnnouncement [
	self
		nodeViewModelFor: anAnnouncement nodeModel
		ifFound: [ :aPipelineViewNode | 
			self
				nodeViewModelFor: anAnnouncement innerNodeModel
				ifFound: [ :anInnerNodeViewNode | 
					aPipelineViewNode
						innerNodeViewModels: (aPipelineViewNode innerNodeViewModels copyWithout: anInnerNodeViewNode).
					anInnerNodeViewNode pipelineNodeViewModel: nil ]
				ifNone: [  ] ]
		ifNone: [  ]
]

{ #category : #'event handling' }
GtWardleyMapViewModel >> onNodeAdded: aNodeAddedAnnouncement [
	| aNodeViewModel |
	nodeViewModels add: (aNodeViewModel := self createNodeViewModelFor: aNodeAddedAnnouncement nodeModel).
	self announce: (GtWardleyMapNodeViewModelAdded new nodeViewModel: aNodeViewModel)
]

{ #category : #'event handling' }
GtWardleyMapViewModel >> onNodePipelineVisibilityChanged: aNodeAddedAnnouncement [
	self
		nodeViewModelFor: aNodeAddedAnnouncement nodeModel
		ifFound: [ :aNodeViewModel | 
			self
				announce: (GtWardleyMapNodeViewModelPipelineVisibilityChanged new nodeViewModel: aNodeViewModel) ]
		ifNone: [  ]
]

{ #category : #'event handling' }
GtWardleyMapViewModel >> onNodeRemoved: aNodeAddedAnnouncement [
	self 
		nodeViewModelFor: aNodeAddedAnnouncement nodeModel
		ifFound: [ :aNodeViewModel |
			nodeViewModels remove: aNodeViewModel.
			self announce: (GtWardleyMapNodeViewModelRemoved new nodeViewModel: aNodeViewModel) ]
		ifNone: [ ]
]

{ #category : #'api - wardley map model' }
GtWardleyMapViewModel >> onWardleyMapModelChanged [
	"Is sent when a new wardleyMap model is assigned to the view model"

	nodeViewModels := self wardleyMapModel nodes
			collect: [ :eachNodeModel | self createNodeViewModelFor: eachNodeModel ]
			as: OrderedCollection.

	"put together pipeline and inner node view models"
	nodeViewModels
		do: [ :eachPipelineViewModel | 
			| innerNodeViewModels |
			innerNodeViewModels := eachPipelineViewModel wardleyMapNodeModel innerNodes
					collect: [ :eachInnerNode | 
						nodeViewModels detect: [ :otherNodeViewModel | 
							otherNodeViewModel wardleyMapNodeModel = eachInnerNode ] ].
			eachPipelineViewModel innerNodeViewModels: innerNodeViewModels.
			innerNodeViewModels do: [ :eachInnerNodeViewModel | 
				eachInnerNodeViewModel pipelineNodeViewModel: eachPipelineViewModel ] ].

	edgeViewModels := self wardleyMapModel edges
			collect: [ :eachEdgeModel | self createEdgeViewModelFor: eachEdgeModel ]
			as: OrderedCollection
]

{ #category : #accessing }
GtWardleyMapViewModel >> predefinedColors [
	^ predefinedColors
]

{ #category : #'api - map' }
GtWardleyMapViewModel >> removeEdgeViewModel: anEdgeViewModel [
	self wardleyMapModel removeEdge: anEdgeViewModel wardleyMapEdgeModel
]

{ #category : #'api - map' }
GtWardleyMapViewModel >> removeNodeViewModel: aNodeViewModel [
	self wardleyMapModel removeNode: aNodeViewModel wardleyMapNodeModel
]

{ #category : #'api - wardley map model' }
GtWardleyMapViewModel >> subscribeToWardleyMapModel [
	"Is sent after a new wardleyMap model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromWardleyMapModel if view model subscribes to them"
	
	self wardleyMapModel weak
		when: GtWardleyMapNodeModelAdded send: #onNodeAdded: to: self;
		when: GtWardleyMapNodeModelRemoved send: #onNodeRemoved: to: self;
		when: GtWardleyMapNodeModelPipelineVisibilityChanged send: #onNodePipelineVisibilityChanged: to: self;
		when: GtWardleyMapNodeModelInnerNodeAdded send: #onInnerNodeAdded: to: self;
		when: GtWardleyMapNodeModelInnerNodeRemoved send: #onInnerNodeRemoved: to: self;
		when: GtWardleyMapEdgeModelAdded send: #onEdgeAdded: to: self;
		when: GtWardleyMapEdgeModelRemoved send: #onEdgeRemoved: to: self
]

{ #category : #'api - wardley map model' }
GtWardleyMapViewModel >> unsubscribeFromWardleyMapModel [
	"Is sent before a new wardleyMap model is assigned to the view model.
	View models that subscribe to wardleyMap model are required to implement this methods"
	
	self wardleyMapModel unsubscribe: self
]
