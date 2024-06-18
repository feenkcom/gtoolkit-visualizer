Class {
	#name : #GtWardleyMapViewModel,
	#superclass : #Object,
	#traits : 'TGtWithWardleyMapModel + TGtAnnouncer + TGtOptions + TGtWithWardleyMapDecoratorViewModels',
	#classTraits : 'TGtWithWardleyMapModel classTrait + TGtAnnouncer classTrait + TGtOptions classTrait + TGtWithWardleyMapDecoratorViewModels classTrait',
	#instVars : [
		'announcer',
		'nodeViewModels',
		'edgeViewModels',
		'predefinedColors',
		'defaultColor',
		'noteViewModels',
		'evolveViewModels',
		'evolveEdgeViewModels'
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
	self
		assert: [ 0 <= aNormalizedPosition x and: [ aNormalizedPosition x <= 1.0 ] ]
		description: [ 'Note x-position must be between 0 and 1: {1}' format: {aNormalizedPosition x} ].
	self
		assert: [ 0 <= aNormalizedPosition y and: [ aNormalizedPosition y <= 1.0 ] ]
		description: [ 'Note y-position must be between 0 and 1: {1}' format: {aNormalizedPosition y} ].

	aNewNode := GtWardleyMapNodeModel new
			coordinate: aNormalizedPosition;
			color: self defaultColor.

	self wardleyMapModel addNode: aNewNode
]

{ #category : #'api - map' }
GtWardleyMapViewModel >> addNewNoteAt: aNormalizedPosition [
	| aNewNote |
	self
		assert: [ 0 <= aNormalizedPosition x and: [ aNormalizedPosition x <= 1.0 ] ]
		description: [ 'Note x-position must be between 0 and 1: {1}' format: {aNormalizedPosition x} ].
	self
		assert: [ 0 <= aNormalizedPosition y and: [ aNormalizedPosition y <= 1.0 ] ]
		description: [ 'Note y-position must be between 0 and 1: {1}' format: {aNormalizedPosition y} ].

	aNewNote := GtWardleyMapNoteModel new
			coordinate: aNormalizedPosition;
			color: self defaultColor.

	self wardleyMapModel addNote: aNewNote
]

{ #category : #announcer }
GtWardleyMapViewModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'api - context menu' }
GtWardleyMapViewModel >> contextMenuItems [
	<return: #Collection of: #TGtWardleyMapContextMenuItem>
	^ self wardleyMapModel contextMenuItems
]

{ #category : #initialization }
GtWardleyMapViewModel >> createEdgeViewModelFor: anEdgeModel [
	^ GtWardleyMapEdgeViewModel new
		wardleyMapViewModel: self;
		wardleyMapEdgeModel: anEdgeModel
]

{ #category : #initialization }
GtWardleyMapViewModel >> createEvolveEdgeViewModelFor: anEvolveViewModel [
	^ GtWardleyMapEvolveEdgeViewModel new
		wardleyMapViewModel: self;
		evolveViewModel: anEvolveViewModel
]

{ #category : #'api - wardley map model' }
GtWardleyMapViewModel >> createEvolveViewModelFor: aNodeModel [
	^ GtWardleyMapEvolveViewModel new
		wardleyMapViewModel: self;
		wardleyMapNodeModel: aNodeModel
]

{ #category : #'api - wardley map model' }
GtWardleyMapViewModel >> createEvolveViewModelForNodeViewModel: aNodeViewModel [ 
	| anEvolveViewModel |
	anEvolveViewModel := self createEvolveViewModelFor: aNodeViewModel wardleyMapNodeModel.
	aNodeViewModel evolveViewModel: anEvolveViewModel.
	anEvolveViewModel nodeViewModel: aNodeViewModel.
	^ anEvolveViewModel
]

{ #category : #initialization }
GtWardleyMapViewModel >> createNodeViewModelFor: aNodeModel [
	^ GtWardleyMapNodeViewModel new
		wardleyMapViewModel: self;
		wardleyMapNodeModel: aNodeModel
]

{ #category : #initialization }
GtWardleyMapViewModel >> createNoteViewModelFor: aNodeModel [
	^ GtWardleyMapNoteViewModel new
		wardleyMapViewModel: self;
		wardleyMapNoteModel: aNodeModel
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

{ #category : #'api - map' }
GtWardleyMapViewModel >> evolveEdgeViewModelFor: aNodeModel ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self evolveEdgeViewModels
		detect: [ :eachEvolveEdgeViewModel | eachEvolveEdgeViewModel fromNodeViewModel wardleyMapNodeModel = aNodeModel ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #accessing }
GtWardleyMapViewModel >> evolveEdgeViewModels [
	^ evolveEdgeViewModels
]

{ #category : #accessing }
GtWardleyMapViewModel >> evolveViewModels [
	<return: #Collection of: #GtWardleyMapEvolveViewModel>

	^ evolveViewModels
]

{ #category : #'gt - extensions' }
GtWardleyMapViewModel >> gtContextMenuItemsFor: aView [
	<gtView>
	^ aView forward
		title: 'Context menu';
		object: [ self wardleyMapModel ];
		view: #gtContextMenuItemsFor:
]

{ #category : #'gt - extensions' }
GtWardleyMapViewModel >> gtEdgesFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Edges';
		priority: 20;
		items: [ self edgeViewModels ];
		column: 'Index' text: [ :_ :anIndex | anIndex ] width: 40;
		column: 'Color' 
			stencil: [ :aNode |
				BlElement new 
					size: 8@8;
					background: aNode lineColor;
					geometry: BlCircleGeometry new;
					margin: (BlInsets left: 3 right: 3);
					constraintsDo: [ :c | 
						c linear vertical alignCenter ] ] 
			width: 40;
		column: 'From' text: [ :anEdge | anEdge fromNodeViewModel label ];
		column: 'To' text: [ :anEdge | anEdge toNodeViewModel label ];
		column: 'Label' text: [ :anEdge | anEdge label ];
		column: 'Visible label' text: [ :anEdge | 
			anEdge isLabelVisible 
				ifTrue: [ 'yes' ] 
				ifFalse: [ 'no' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ] ]
]

{ #category : #'gt - extensions' }
GtWardleyMapViewModel >> gtEvolveEdgesFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Evolve edges';
		priority: 22;
		items: [ self evolveEdgeViewModels ];
		column: 'Index' text: [ :_ :anIndex | anIndex ] width: 40;
		column: 'Color' 
			stencil: [ :aNode |
				BlElement new 
					size: 8@8;
					background: aNode lineColor;
					geometry: BlCircleGeometry new;
					margin: (BlInsets left: 3 right: 3);
					constraintsDo: [ :c | 
						c linear vertical alignCenter ] ] 
			width: 40;
		column: 'From' text: [ :anEdge | anEdge fromNodeViewModel label ];
		column: 'To' text: [ :anEdge | anEdge toNodeViewModel label ];
		column: 'Label' text: [ :anEdge | anEdge label ];
		column: 'Visible label' text: [ :anEdge | 
			anEdge isLabelVisible 
				ifTrue: [ 'yes' ] 
				ifFalse: [ 'no' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ] ]
]

{ #category : #'gt - extensions' }
GtWardleyMapViewModel >> gtEvolveViewsFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Evolve nodes';
		priority: 22;
		items: [ self evolveViewModels ];
		column: 'Index' text: [ :_ :anIndex | anIndex ] width: 40;
		column: 'Color' 
			stencil: [ :aNode |
				BlElement new 
					size: 8@8;
					background: aNode nodeColor;
					geometry: BlCircleGeometry new;
					margin: (BlInsets left: 3 right: 3);
					constraintsDo: [ :c | 
						c linear vertical alignCenter ] ] 
			width: 40;
		column: 'Name' text: #label;
		column: 'X' text: [ :aNode | aNode coordinateX printShowingDecimalPlaces: 3 ] width: 50;
		column: 'Y' text: [ :aNode | aNode coordinateY printShowingDecimalPlaces: 3 ] width: 50;
		column: 'Visible label' text: [ :aNode | aNode isLabelVisible
			ifTrue: [ 'yes' ] ifFalse: [ 'no' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ] ] width: 80;
		column: 'Label X' text: [ :aNode | aNode labelCoordinateX printShowingDecimalPlaces: 3 ] width: 50;
		column: 'Label Y' text: [ :aNode | aNode labelCoordinateY printShowingDecimalPlaces: 3 ] width: 50
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

{ #category : #'gt - extensions' }
GtWardleyMapViewModel >> gtNodeViewsFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Nodes';
		priority: 20;
		items: [ self nodeViewModels ];
		column: 'Index' text: [ :_ :anIndex | anIndex ] width: 40;
		column: 'Color' 
			stencil: [ :aNode |
				BlElement new 
					size: 8@8;
					background: aNode nodeColor;
					geometry: BlCircleGeometry new;
					margin: (BlInsets left: 3 right: 3);
					constraintsDo: [ :c | 
						c linear vertical alignCenter ] ] 
			width: 40;
		column: 'Name' text: #label;
		column: 'With pipeline' 
			text: [ :aNode | aNode isPipelineVisible 
				ifTrue: [ 'yes' ] 
				ifFalse: [ 'no' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ] ]
			width: 85;
		column: 'Inner nodes' 
			text: [ :aNode | 
				| aSize |
				aSize := aNode innerNodeViewModels size.
				aSize isZero 
					ifTrue: [ aSize asRopedText foreground: BrGlamorousColors disabledButtonTextColor ]
					ifFalse: [ aSize ] ]
			 width: 80;
		column: 'Evolve' text: [ :aNode | 
			aNode isEvolveVisible
				ifFalse: [ 'no' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ]
				ifTrue: [ aNode evolveViewModel label ] ];
		column: 'X' text: [ :aNode | aNode coordinateX printShowingDecimalPlaces: 3 ] width: 50;
		column: 'Y' text: [ :aNode | aNode coordinateY printShowingDecimalPlaces: 3 ] width: 50;
		column: 'Label X' text: [ :aNode | aNode labelCoordinateX printShowingDecimalPlaces: 3 ] width: 50;
		column: 'Label Y' text: [ :aNode | aNode labelCoordinateY printShowingDecimalPlaces: 3 ] width: 50
]

{ #category : #'gt - extensions' }
GtWardleyMapViewModel >> gtNotesFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Notes';
		priority: 25;
		items: [ self noteViewModels ];
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
			width: 40;
		column: 'Text' text: #label
]

{ #category : #'gt - extensions' }
GtWardleyMapViewModel >> gtWardleyMapDecorators [
	^ Array streamContents: [ :aStream | 
	 	self nodeViewModels do: [ :each | 
	 		each wardleyMapDecoratorViewModels do: [ :aDecorator | 
	 			aStream nextPut: each -> aDecorator ] ].
	 	self edgeViewModels do: [ :each | 
	 		each wardleyMapDecoratorViewModels do: [ :aDecorator | 
	 			aStream nextPut: each -> aDecorator ] ] ]
]

{ #category : #'gt - extensions' }
GtWardleyMapViewModel >> gtWardleyMapDecoratorsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Decorators';
		priority: 30;
		items: [ self gtWardleyMapDecorators ];
		column: 'Item' text: [ :anAssoc | anAssoc key ];
		column: 'Decorator' text: [ :anAssoc | anAssoc value ];
		send: #value
]

{ #category : #initialization }
GtWardleyMapViewModel >> initialize [
	super initialize.

	nodeViewModels := OrderedCollection new.
	edgeViewModels := OrderedCollection new.
	noteViewModels := OrderedCollection new.
	evolveViewModels := OrderedCollection new.
	evolveEdgeViewModels := OrderedCollection new.

	predefinedColors := {Color black.
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
			Color orange muchDarker.
			Color orange darker.
			Color orange.
			Color orange lighter.
			Color orange muchLighter.
			Color blue muchDarker.
			Color blue darker.
			Color blue.
			Color blue lighter.
			Color blue muchLighter.
			Color green muchDarker.
			Color green twiceDarker.
			Color green darker.
			Color green lighter.
			Color green muchLighter}.

	defaultColor := GtWardleyMapConstants nodeColor
]

{ #category : #'api - map' }
GtWardleyMapViewModel >> isTitleVisible [
	<return: #Boolean>
	^ self wardleyMapModel isTitleVisible
]

{ #category : #'api - map' }
GtWardleyMapViewModel >> isTitleVisible: aBoolean [
	self wardleyMapModel isTitleVisible: aBoolean
]

{ #category : #'api - wardley map model' }
GtWardleyMapViewModel >> mapDecoratorViewModelFor: aWardleyMapDecoratorModel ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self wardleyMapDecoratorViewModels
		detect: [ :each | each wardleyMapDecoratorModel == aWardleyMapDecoratorModel ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
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

{ #category : #'api - map' }
GtWardleyMapViewModel >> noteViewModelFor: aNodeModel ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self noteViewModels
		detect: [ :eachNoteViewModel | eachNoteViewModel wardleyMapNoteModel = aNodeModel ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #accessing }
GtWardleyMapViewModel >> noteViewModels [
	<return: #Collection of: #GtWardleyMapNoteViewModel>

	^ noteViewModels
]

{ #category : #accessing }
GtWardleyMapViewModel >> notifyWardleyMapDecoratorViewModelAdded: aWardleyMapDecoratorViewModel [
	self
		announce: (GtWardleyMapDecoratorViewModelAdded new
				mapViewModel: self;
				decoratorViewModel: aWardleyMapDecoratorViewModel)
]

{ #category : #'api - wardley map decorator view models' }
GtWardleyMapViewModel >> notifyWardleyMapDecoratorViewModelRemoved: aWardleyMapDecoratorViewModel [
	self
		announce: (GtWardleyMapDecoratorViewModelRemoved new
				mapViewModel: self;
				decoratorViewModel: aWardleyMapDecoratorViewModel)
]

{ #category : #'api - wardley map model' }
GtWardleyMapViewModel >> onDecoratorAdded: anAnnouncement [
	self onWardleyMapDecoratorModelAdded: anAnnouncement decoratorModel
]

{ #category : #'api - wardley map model' }
GtWardleyMapViewModel >> onDecoratorRemoved: anAnnouncement [
	self onWardleyMapDecoratorModelRemoved: anAnnouncement decoratorModel
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
			anEdgeViewModel announce: (GtWardleyMapEdgeViewModelRemoved new edgeViewModel: anEdgeViewModel).
			self announce: (GtWardleyMapEdgeViewModelRemoved new edgeViewModel: anEdgeViewModel) ]
		ifNone: [ ]
]

{ #category : #'event handling' }
GtWardleyMapViewModel >> onEvolveAdded: anAnnouncement [ 
	| aNodeModel |
	aNodeModel := anAnnouncement nodeModel.
	self
		nodeViewModelFor: aNodeModel
		ifFound: [ :aNodeViewModel | 
			| anEvolveViewModel anEvolveEdgeViewModel |
			anEvolveViewModel := self createEvolveViewModelForNodeViewModel: aNodeViewModel.
			anEvolveEdgeViewModel := self createEvolveEdgeViewModelFor: anEvolveViewModel.
			evolveViewModels add: anEvolveViewModel.
			evolveEdgeViewModels add: anEvolveEdgeViewModel.
			self announce: (GtWardleyMapEvolveViewModelAdded new 
				evolveViewModel: anEvolveViewModel;
				evolveEdgeViewModel: anEvolveEdgeViewModel) ]
		ifNone: [  ]
]

{ #category : #'event handling' }
GtWardleyMapViewModel >> onEvolveRemoved: anAnnouncement [ 
	| aNodeModel |
	aNodeModel := anAnnouncement nodeModel.
	self
		evolveEdgeViewModelFor: aNodeModel
		ifFound: [ :anEvolveEdgeViewModel | 
			| anEvolveViewModel |
			anEvolveViewModel := anEvolveEdgeViewModel evolveViewModel.
			evolveEdgeViewModels remove: anEvolveEdgeViewModel ifAbsent: [ nil ].
			evolveViewModels remove: anEvolveViewModel ifAbsent: [ nil ].
			self announce: (GtWardleyMapEvolveViewModelRemoved new 
				evolveViewModel: anEvolveViewModel;
				evolveEdgeViewModel: anEvolveEdgeViewModel) ]
		ifNone: [  ]
]

{ #category : #'event handling' }
GtWardleyMapViewModel >> onEvolveVisibilityChanged: anAnnouncement [
	anAnnouncement nodeModel isEvolveVisible
		ifTrue: [ self onEvolveAdded: anAnnouncement ]
		ifFalse: [ self onEvolveRemoved: anAnnouncement ]
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
			aNodeViewModel announce: (GtWardleyMapNodeViewModelRemoved new nodeViewModel: aNodeViewModel).
			self announce: (GtWardleyMapNodeViewModelRemoved new nodeViewModel: aNodeViewModel) ]
		ifNone: [ ]
]

{ #category : #'event handling' }
GtWardleyMapViewModel >> onNoteAdded: aNoteAddedAnnouncement [
	| aNoteViewModel |
	noteViewModels add: (aNoteViewModel := self createNoteViewModelFor: aNoteAddedAnnouncement noteModel).
	self announce: (GtWardleyMapNoteViewModelAdded new noteViewModel: aNoteViewModel)
]

{ #category : #'event handling' }
GtWardleyMapViewModel >> onNoteRemoved: aNoteAddedAnnouncement [
	self 
		noteViewModelFor: aNoteAddedAnnouncement noteModel
		ifFound: [ :aNoteViewModel |
			noteViewModels remove: aNoteViewModel.
			self announce: (GtWardleyMapNoteViewModelRemoved new noteViewModel: aNoteViewModel) ]
		ifNone: [ ]
]

{ #category : #'event handling' }
GtWardleyMapViewModel >> onTitleChanged: anAnnouncement [
	self announce: (GtWardleyMapViewModelTitleChanged new )
]

{ #category : #'event handling' }
GtWardleyMapViewModel >> onTitleVisibilityChanged: anAnnouncement [
	self announce: (GtWardleyMapViewModelTitleVisibilityChanged new )
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

	"create evolve view models"
	evolveViewModels := (nodeViewModels select: #isEvolveVisible)
		collect: [ :aNodeViewModel | self createEvolveViewModelForNodeViewModel: aNodeViewModel ] 
		as: OrderedCollection.
	
	"create edge view models"
	edgeViewModels := self wardleyMapModel edges
			collect: [ :eachEdgeModel | self createEdgeViewModelFor: eachEdgeModel ]
			as: OrderedCollection.
			
	"create evolve edge view models"
	evolveEdgeViewModels := evolveViewModels
			collect: [ :eachEvolveViewModel | self createEvolveEdgeViewModelFor: eachEvolveViewModel ]
			as: OrderedCollection.
			
	noteViewModels := self wardleyMapModel notes
			collect: [ :eachNoteModel | self createNoteViewModelFor: eachNoteModel ]
			as: OrderedCollection.
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

{ #category : #'api - map' }
GtWardleyMapViewModel >> removeNoteViewModel: aNodeViewModel [
	self wardleyMapModel removeNote: aNodeViewModel wardleyMapNoteModel
]

{ #category : #'api - wardley map model' }
GtWardleyMapViewModel >> subscribeToWardleyMapModel [
	"Is sent after a new wardleyMap model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromWardleyMapModel if view model subscribes to them"

	self wardleyMapModel weak
		when: GtWardleyMapTitleChanged
			send: #onTitleChanged:
			to: self;
		when: GtWardleyMapTitleVisibilityChanged
			send: #onTitleVisibilityChanged:
			to: self;
		when: GtWardleyMapNodeModelAdded
			send: #onNodeAdded:
			to: self;
		when: GtWardleyMapNodeModelRemoved
			send: #onNodeRemoved:
			to: self;
		when: GtWardleyMapNodeModelPipelineVisibilityChanged
			send: #onNodePipelineVisibilityChanged:
			to: self;
		when: GtWardleyMapNodeModelInnerNodeAdded
			send: #onInnerNodeAdded:
			to: self;
		when: GtWardleyMapNodeModelInnerNodeRemoved
			send: #onInnerNodeRemoved:
			to: self;
		when: GtWardleyMapEdgeModelAdded
			send: #onEdgeAdded:
			to: self;
		when: GtWardleyMapEdgeModelRemoved
			send: #onEdgeRemoved:
			to: self;
		when: GtWardleyMapNoteModelAdded
			send: #onNoteAdded:
			to: self;
		when: GtWardleyMapNoteModelRemoved
			send: #onNoteRemoved:
			to: self;
		when: GtWardleyMapNodeModelEvolveVisibilityChanged
			send: #onEvolveVisibilityChanged:
			to: self;
		when: GtWardleyMapNodeDecoratorModelAdded
			send: #onDecoratorAdded:
			to: self;
		when: GtWardleyMapNodeDecoratorModelRemoved
			send: #onDecoratorRemoved:
			to: self
]

{ #category : #'api - map' }
GtWardleyMapViewModel >> title [
	<return: #String>
	^ self wardleyMapModel title
]

{ #category : #'api - map' }
GtWardleyMapViewModel >> title: aString [
	self wardleyMapModel title: aString
]

{ #category : #'api - wardley map model' }
GtWardleyMapViewModel >> unsubscribeFromWardleyMapModel [
	"Is sent before a new wardleyMap model is assigned to the view model.
	View models that subscribe to wardleyMap model are required to implement this methods"
	
	self wardleyMapModel unsubscribe: self
]
