"
#Technical details
##Element elevations
- {{gtClass:GtWardleyMapNodeElement}}'s {{gtMethod: BlElement>>#elevation | label=#selector}} default value is `-1`
- {{gtClass: GtWardleyMapNodeElement}}'s {{gtMethod: BlElement>>#elevation | label=#selector}} default value is `2` and `3` while dragging
- {{gtClass: GtWardleyMapPipelineElement}}'s {{gtMethod: BlElement>>#elevation | label=#selector}} default value is `0` and `1` while dragging

"
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
					do: [ :theElement | theElement border: (BlBorder paint: (self hoverColorFrom: anEdgeViewModel lineColor) width: 1) ]
					after: [ :theElement | theElement border: (BlBorder paint: anEdgeViewModel lineColor width: 1) ] ]);
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
					aStyle 
						do: [ :theElement | 
							theElement background: (self hoverColorFrom: aNodeViewModel nodeColor).
							theElement labelElementDo: [ :aLabelElement | 
								aLabelElement aptitude foreground: (
									self hoverColorFrom: aNodeViewModel labelColor) ] ]
						after: [ :theElement | 
							theElement background: aNodeViewModel nodeColor.
							theElement labelElementDo: [ :aLabelElement | 
								aLabelElement aptitude foreground: aNodeViewModel labelColor ] ] ]);
		labelElementDo: [ :aLabelElement | 
			aLabelElement addAptitude: (BrStyleCommonAptitude new 
				hovered: [ :aStyle | 
					aStyle 
						do: [ :theLabelElement | 
							theLabelElement aptitude foreground: (self hoverColorFrom: aNodeViewModel labelColor) ]
						after: [ :theLabelElement | 
							theLabelElement aptitude foreground: (aNodeViewModel labelColor) ] ]) ];
		addEventHandler: (GtWardleyMapNodePullHandler new
				containerElement: self;
				disallowOutOfBounds;
				whenPulled: [ :aPulledElement :aNormalizedPosition | 
					aNodeViewModel moveNodeTo: aNormalizedPosition ]);
		addEventHandler: (GtWardleyMapEdgeBuilder new containerElement: self);
		zIndex: self defaultNodeElevationIndex;
		constraintsDo: [ :c | 
			c graph beNode ];
		in: [ :theElement |
			GtWardleyMapUtility updateNodeElement: theElement nodeViewModel: aNodeViewModel ];
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
			hovered: [ :aStyle | 
				aStyle 
						do: [ :theElement | 
							theElement border: (BlBorder paint: (self hoverColorFrom: aNodeViewModel pipelineColor) width: 2) ]
						after: [ :theElement | 
							theElement border: (BlBorder paint: aNodeViewModel pipelineColor width: 1) ]
				 ]);
		addEventHandler: (GtWardleyMapPipelinePullHandler new
				disallowOutOfBounds;
				containerElement: self;
				whenPulled: [ :aPulledElement :aNormalizedPosition | 
					aNodeViewModel moveNodePipelineTo: aNormalizedPosition ]);
		zIndex: self defaultPipelineElevationIndex;
		in: [ :thePipelineElement | 
			thePipelineElement wardley bePipeline. ];
		in: [ :theElement |
			GtWardleyMapUtility
				updatePipelineElement: theElement
				nodeViewModel: aNodeViewModel ];
		addAptitude: (BrGlamorousWithContextMenuAptitude
				handle: [ BlElement new
						size: aNodeViewModel nodeSize / 2.0;
						geometry: BlEllipseGeometry new ]
				content: [ self createNodeEditorFor: aNodeViewModel ])
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> defaultNodeElevationIndex [
	^ 2
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> defaultPipelineElevationIndex [
	^ 0
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> draggingNodeElevationIndex [
	^ 3
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> draggingPipelineElevationIndex [
	^ 1
]

{ #category : #private }
GtWardleyMapCanvasElement >> edgeViewFor: anEdgeViewModel ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self children
		detect: [ :eachChild | eachChild graph isEdge and: [ eachChild wardleyMapEdgeViewModel = anEdgeViewModel ] ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #accessing }
GtWardleyMapCanvasElement >> hoverColorFrom: aColor [
	| aNewColor |
	true ifTrue: [ ^ BrGlamorousColors hoveredButtonBorderColor ].
	
	aNewColor := aColor muchDarker.
	aColor = aNewColor ifFalse: [ ^ aNewColor ].
	
	aNewColor := aColor muchLighter.
	aColor = aNewColor ifFalse: [ ^ aNewColor ].
	
	aNewColor := Color lightOrange.
	aColor = aNewColor ifFalse: [ ^ aNewColor ].
	
	aNewColor := Color lightBrown.
	aColor = aNewColor ifFalse: [ ^ aNewColor ].
	
	^ aColor
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
	| anInnerNodeViewModel aPipelineNodeViewModel |
	anInnerNodeViewModel := anAnnouncement innerNodeViewModel.
	aPipelineNodeViewModel := anAnnouncement pipelineViewModel.

	self
		nodeViewFor: anInnerNodeViewModel
		ifFound: [ :aNodeView | 
			GtWardleyMapUtility
				updateNodeElement: aNodeView
				nodeViewModel: anInnerNodeViewModel ]
		ifNone: [  ].

	self
		pipelineViewFor: aPipelineNodeViewModel
		ifFound: [ :aPipelineView | 
			GtWardleyMapUtility
				updatePipelineElement: aPipelineView
				nodeViewModel: aPipelineNodeViewModel ]
		ifNone: [  ]
]

{ #category : #'event handling' }
GtWardleyMapCanvasElement >> onNodeAdded: anAnnouncement [
	| aNodeElement aNodeViewModel |
	aNodeViewModel := anAnnouncement nodeViewModel.
	aNodeElement := self createNodeViewFor: aNodeViewModel.

	"If the node element is added inside of a pipeline element,
	let's add the node element also as a pipeline inner node."
	(aNodeViewModel isPipelineVisible not
		and: [ aNodeViewModel pipelineNodeViewModel isNil ]) ifTrue: [ 
			aNodeElement
				when: BlElementLayoutComputedEvent
				doOnce: [ :anEvent | 
					self pipelineChildrenDo: [ :aPipelineElement | 
						aNodeViewModel pipelineNodeViewModel ifNil: [ 
							(GtWardleyMapUtility
								isNodeElement: aNodeElement
								insidePipelineElement: aPipelineElement) ifTrue: [ 
									aPipelineElement wardleyMapNodeViewModel addInnerNodeViewModel: aNodeViewModel ] ] ] ] ].
									
	self addChild: aNodeElement
]

{ #category : #'event handling' }
GtWardleyMapCanvasElement >> onNodeMoved: anAnnouncement [
	| aMovedNodeViewModel |
	aMovedNodeViewModel := anAnnouncement nodeViewModel.

	self
		nodeViewFor: aMovedNodeViewModel
		ifFound: [ :aNodeView | 
			GtWardleyMapUtility 
				updateNodeElement: aNodeView 
				nodeViewModel: aMovedNodeViewModel ]
		ifNone: [  ].

	aMovedNodeViewModel isPipelineVisible ifTrue: [
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
