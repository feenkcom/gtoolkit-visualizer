Class {
	#name : #GtWardleyMapCanvasElement,
	#superclass : #BlPannableElement,
	#traits : 'TGtWithWardleyMapViewModel',
	#classTraits : 'TGtWithWardleyMapViewModel classTrait',
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #initialization }
GtWardleyMapCanvasElement >> createEdgeViewFor: anEdgeViewModel [
	| aFromNodeElement aToNodeElement |

	aFromNodeElement := self
		nodeViewFor: anEdgeViewModel fromNodeViewModel
		ifFound: [ :anElement | anElement ]
		ifNone: [ ^ self ].

	aToNodeElement := self
		nodeViewFor: anEdgeViewModel toNodeViewModel
		ifFound: [ :anElement | anElement ]
		ifNone: [ ^ self ].

	^ GtWardleyMapEdgeElement new
		in: [ :aLineElement | aLineElement graph beEdge ];
		wardleyMapEdgeViewModel: anEdgeViewModel;
		addAptitude: (BrStyleCommonAptitude new 
				hovered: [ :aStyle | aStyle 
					do: [ :theElement | theElement background: anEdgeViewModel lineColor muchDarker ]
					after: [ :theElement | theElement background: anEdgeViewModel lineColor ] ]);
		fromAnchor: (BlNearestPositionEllipseAnchor referenceElement: aFromNodeElement relatedTo: aToNodeElement);
		toAnchor: (BlNearestPositionEllipseAnchor referenceElement: aToNodeElement relatedTo: aFromNodeElement);
		zIndex: -1;
		addAptitude: (BrGlamorousWithContextMenuAptitude
			handle: [ BlElement new
					size: 5@5;
					geometry: BlEllipseGeometry new ]
			content: [ GtWardleyMapEdgeEditorElement new
				wardleyMapViewModel: self wardleyMapViewModel;
				wardleyMapEdgeViewModel: anEdgeViewModel;
				requestFocus ])
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> createNodeEditorFor: aNodeViewModel [
	^ GtWardleyMapNodeEditorElement new
		wardleyMapViewModel: self wardleyMapViewModel;
		wardleyMapNodeViewModel: aNodeViewModel
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> createNodeViewFor: aNodeViewModel [
	^ GtWardleyMapNodeElement new
		wardleyMapNodeViewModel: aNodeViewModel;
		addAptitude: (BrStyleCommonAptitude new 
				hovered: [ :aStyle | 
					aStyle effect: BrGlamorousFocusedShadowEffect new.
					aStyle 
						do: [ :theElement | 
							theElement background: aNodeViewModel labelColor ]
						after: [ :theElement | 
							theElement background: aNodeViewModel nodeColor ] ]);
		addEventHandler: (GtWardleyMapNodePullHandler new
				containerElement: self;
				disallowOutOfBounds;
				whenPulled: (GtWardleyMapNodePulledAction new
					containerElement: self);
				whenFinished: (GtWardleyMapNodePullFinishedAction new
					containerElement: self));
		addEventHandler: (GtWardleyMapEdgeBuilder new containerElement: self);
		constraintsDo: [ :c | 
			c frame horizontal alignCenterAt: aNodeViewModel coordinateX.
			c frame vertical alignCenterAt: aNodeViewModel coordinateY.
			c graph beNode ];
		in: [ :theElement |
			GtWardleyMapBeaconNodeInitializedSignal new 
				nodeElement: theElement;
				mapElement: self ];
		addAptitude: (BrGlamorousWithContextMenuAptitude
				handle: [ BlElement new
						size: aNodeViewModel nodeSize / 2.0;
						geometry: BlEllipseGeometry new ]
				content: [ self createNodeEditorFor: aNodeViewModel ])
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> createPipelineViewFor: aNodeViewModel [
	^ GtWardleyMapPipelineElement new
		wardleyMapNodeViewModel: aNodeViewModel;
		addAptitude: (BrStyleCommonAptitude new 
			hovered: [ :aStyle | aStyle effect: BrGlamorousFocusedShadowEffect new ]);
		addEventHandler: (GtWardleyMapPipelinePullHandler new
				disallowOutOfBounds;
				containerElement: self;
				whenPulled: [ :aPulledElement :aNormalizedPosition | 
					aNodeViewModel moveNodePipelineTo: aNormalizedPosition.
					GtWardleyMapUtility 
						snapInnerNodeElementsInPipelineElement: aPulledElement 
						inCanvasElement: self ]);
		in: [ :thePipelineElement | 
			thePipelineElement wardley bePipeline.

			GtWardleyMapUtility
				updatePipelineElement: thePipelineElement
				nodeViewModel: aNodeViewModel ];
		yourself
]

{ #category : #private }
GtWardleyMapCanvasElement >> edgeViewFor: anEdgeViewModel ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self children
		detect: [ :eachChild | eachChild graph isEdge and: [ eachChild wardleyMapEdgeViewModel = anEdgeViewModel ] ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> initialize [
	super initialize.

	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	self layout: BlFrameLayout new.
	(self addAptitude: (BrGlamorousWithContextMenuAptitude
			handle: [ BlElement new
					size: 5@5;
					geometry: BlEllipseGeometry new ]
			content: [ GtWardleyMapEditorElement new
				canvas: self;
				requestFocus ])).
	self
		when: BlDoubleClickEvent
		do: [ :anEvent |
			anEvent consumed: true.
			(self width isZero or: [ self height isZero ])
				ifFalse: [ self wardleyMapViewModel addNewNodeAt: anEvent localPosition / self extent ] ].
				
	self addEventHandler: (GtWardleyMapInnerNodeSnapper new)
]

{ #category : #private }
GtWardleyMapCanvasElement >> nodeViewFor: aNodeViewModel ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self children
		detect: [ :eachChild | eachChild graph isNode and: [ eachChild wardleyMapNodeViewModel = aNodeViewModel ] ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'event handling' }
GtWardleyMapCanvasElement >> onEdgeAdded: anAnnouncement [

	self addChild: (self createEdgeViewFor: anAnnouncement edgeViewModel)
]

{ #category : #'event handling' }
GtWardleyMapCanvasElement >> onEdgeRemoved: anAnnouncement [

	self
		edgeViewFor: anAnnouncement edgeViewModel
		ifFound: [ :aNodeElement | aNodeElement removeFromParent ]
		ifNone: [ ]
]

{ #category : #'event handling' }
GtWardleyMapCanvasElement >> onInnerNodeAdded: anAnnouncement [

	GtWardleyMapUtility 
		snapInnerNodeViewModel: anAnnouncement innerNodeViewModel
		inPipelineViewModel: anAnnouncement pipelineViewModel
		inCanvasElement: self
]

{ #category : #'event handling' }
GtWardleyMapCanvasElement >> onNodeAdded: anAnnouncement [

	self addChild: (self createNodeViewFor: anAnnouncement nodeViewModel)
]

{ #category : #'event handling' }
GtWardleyMapCanvasElement >> onNodeMoved: anAnnouncement [
	| aMovedNodeViewModel |
	aMovedNodeViewModel := anAnnouncement nodeViewModel.

	self
		nodeViewFor: aMovedNodeViewModel
		ifFound: [ :aNodeView | 
			aNodeView
				constraintsDo: [ :c | 
					c frame horizontal alignCenterAt: aMovedNodeViewModel coordinateX.
					c frame vertical alignCenterAt: aMovedNodeViewModel coordinateY ].
				GtWardleyMapBeaconNodeMovedSignal new 
					nodeElement: aNodeView;
					mapElement: self;
					emit ]
		ifNone: [  ].

	aMovedNodeViewModel isPipelineVisible ifFalse: [
		self
			pipelineViewFor: aMovedNodeViewModel
			ifFound: [ :aPipelineView | 
				GtWardleyMapUtility
					updatePipelineElement: aPipelineView
					nodeViewModel: aMovedNodeViewModel ]
			ifNone: [  ] ]
]

{ #category : #'api - wardley map view model' }
GtWardleyMapCanvasElement >> onNodePipelineVisibilityChanged: anAnnouncement [
	| aChangedNodeViewModel |
	aChangedNodeViewModel := anAnnouncement nodeViewModel.

	self
		pipelineViewFor: aChangedNodeViewModel
		ifFound: [ :aPipelineView | 
			aChangedNodeViewModel isPipelineVisible
				ifTrue: [ GtWardleyMapUtility
						updatePipelineElement: aPipelineView
						nodeViewModel: aChangedNodeViewModel ]
				ifFalse: [ aPipelineView removeFromParent ] ]
		ifNone: [ aChangedNodeViewModel isPipelineVisible
				ifTrue: [ self addChildFirst: (self createPipelineViewFor: aChangedNodeViewModel) ] ]
]

{ #category : #'event handling' }
GtWardleyMapCanvasElement >> onNodeRemoved: anAnnouncement [
	self
		nodeViewFor: anAnnouncement nodeViewModel
		ifFound: [ :aNodeElement | aNodeElement removeFromParent ]
		ifNone: [ ]
]

{ #category : #'api - wardley map view model' }
GtWardleyMapCanvasElement >> onWardleyMapViewModelChanged [
	"Is sent when a new WardleyMap view model is assigned to the element"
	| theNodeElements theEdgeElements thePipelineElements |

	self removeChildren.
	theNodeElements := self wardleyMapViewModel nodeViewModels collect: [ :eachNodeViewModel |
		self createNodeViewFor: eachNodeViewModel ].
	
	thePipelineElements := Array streamContents: [ :aStream |  
		self wardleyMapViewModel nodeViewModels do: [ :eachNodeViewModel | 
			eachNodeViewModel isPipelineVisible ifTrue: [ 
				aStream nextPut: (self createPipelineViewFor: eachNodeViewModel) ] ] ].
	
	self addChildren: thePipelineElements.
	self addChildren: theNodeElements.
	
	theEdgeElements := self wardleyMapViewModel edgeViewModels collect: [ :eachEdgeViewModel |
		self createEdgeViewFor: eachEdgeViewModel ].
		
	self addChildren: theEdgeElements.

	"When layout computation is finished, snap inner nodes"
	self when: BlElementLayoutComputedEvent doOnce: [ :anEvent |
		self space ifNotNil: [
			thePipelineElements do: [ :aPipelineElement |
				aPipelineElement wardleyMapNodeViewModel innerNodeViewModels do: [ :anInnerNodeViewModel |
					GtWardleyMapUtility 
						snapInnerNodeViewModel: anInnerNodeViewModel
						inPipelineViewModel: aPipelineElement wardleyMapNodeViewModel 
						inCanvasElement: self
				]
			]
		] 
	].
]

{ #category : #private }
GtWardleyMapCanvasElement >> pipelineChildrenDo: aDoBlock [
	^ self childrenDo: [ :eachChild | 
		eachChild wardley isPipeline 
			ifTrue: [ aDoBlock value: eachChild ] ]
]

{ #category : #private }
GtWardleyMapCanvasElement >> pipelineViewFor: aNodeViewModel ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self children
		detect: [ :eachChild | 
			eachChild wardley isPipeline
				and: [ eachChild wardleyMapNodeViewModel = aNodeViewModel ] ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'api - wardley map view model' }
GtWardleyMapCanvasElement >> subscribeToWardleyMapViewModel [
	"Is sent after a new WardleyMap view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapViewModel if elements subscribe to them"
	
	self wardleyMapViewModel weak
		when: GtWardleyMapNodeViewModelMoved send: #onNodeMoved: to: self;
		when: GtWardleyMapNodeViewModelAdded send: #onNodeAdded: to: self;
		when: GtWardleyMapNodeViewModelRemoved send: #onNodeRemoved: to: self;
		when: GtWardleyMapNodeViewModelPipelineVisibilityChanged send: #onNodePipelineVisibilityChanged: to: self;
		when: GtWardleyMapNodeViewModelInnerNodeAdded send: #onInnerNodeAdded: to: self;
		when: GtWardleyMapEdgeViewModelAdded send: #onEdgeAdded: to: self;
		when: GtWardleyMapEdgeViewModelRemoved send: #onEdgeRemoved: to: self
]

{ #category : #'api - wardley map view model' }
GtWardleyMapCanvasElement >> unsubscribeFromWardleyMapViewModel [
	"Is sent before a new WardleyMap view model is assigned to the element.
	Elements that subscribe to WardleyMap view model in domain model are required to implement this methods"
	
	self wardleyMapViewModel unsubscribe: self
]
