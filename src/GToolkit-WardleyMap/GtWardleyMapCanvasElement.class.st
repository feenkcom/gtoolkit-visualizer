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
	#instVars : [
		'idGenerator'
	],
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #'private - updating' }
GtWardleyMapCanvasElement >> addEdgeViewModel: anEdgeViewModel [
	| anEdgeElement |
	anEdgeElement := self createEdgeViewFor: anEdgeViewModel.
	self addChild: anEdgeElement.
	self fireEvent: (GtWardleyMapEdgeElementAdded new
			edgeElement: anEdgeElement;
			edgeViewModel: anEdgeViewModel)
]

{ #category : #'private - updating' }
GtWardleyMapCanvasElement >> addEvolveEdgeViewModel: anEvolveEdgeViewModel [
	| aEvolveViewModel anEvolveEdgeElement aEvolveElement |
	aEvolveViewModel := anEvolveEdgeViewModel evolveViewModel.
	aEvolveElement := self createEvolveViewFor: aEvolveViewModel.	"If the node element is added inside of a pipeline element,
	let's add the node element also as a pipeline inner node."
	(aEvolveViewModel isPipelineVisible not
		and: [ aEvolveViewModel pipelineNodeViewModel isNil ])
		ifTrue: [ aEvolveElement
				when: BlElementLayoutComputedEvent
				doOnce: [ :anEvent | 
					self
						pipelineChildrenDo: [ :aPipelineElement | 
							aEvolveViewModel pipelineNodeViewModel
								ifNil: [ (GtWardleyMapUtility
										isNodeElement: aEvolveElement
										insidePipelineElement: aPipelineElement)
										ifTrue: [ aPipelineElement wardleyMapNodeViewModel
												addInnerNodeViewModel: aEvolveViewModel ] ] ] ] ].

	self addChild: aEvolveElement.

	anEvolveEdgeElement := self createEvolveEdgeViewFor: anEvolveEdgeViewModel.
	self addChild: anEvolveEdgeElement
]

{ #category : #'private - updating' }
GtWardleyMapCanvasElement >> addNewNodeViewModel: aNodeViewModel [
	| aNodeElement |
	aNodeElement := self createNodeViewFor: aNodeViewModel.	
	
	"If the node element is added inside of a pipeline element,
	let's add the node element also as a pipeline inner node."
	(aNodeViewModel isPipelineVisible not
		and: [ aNodeViewModel pipelineNodeViewModel isNil ])
		ifTrue: [ aNodeElement
				when: BlElementLayoutComputedEvent
				doOnce: [ :anEvent | 
					self
						pipelineChildrenDo: [ :aPipelineElement | 
							aNodeViewModel pipelineNodeViewModel
								ifNil: [ (GtWardleyMapUtility
										isNodeElement: aNodeElement
										insidePipelineElement: aPipelineElement)
										ifTrue: [ aPipelineElement wardleyMapNodeViewModel addInnerNodeViewModel: aNodeViewModel ] ] ] ] ].

	self addChild: aNodeElement.
	self fireEvent: (GtWardleyMapNodeElementAdded new 
		nodeElement: aNodeElement;
		nodeViewModel: aNodeViewModel)
]

{ #category : #'private - updating' }
GtWardleyMapCanvasElement >> addNoteViewModel: aNoteViewModel [
	| aNoteElement |
	aNoteElement := self createNoteViewFor: aNoteViewModel.

	self addChild: aNoteElement
]

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
		id: self newEdgeId;
		wardleyMapEdgeViewModel: anEdgeViewModel;
		fromAnchor: (BlNearestPositionEllipseAnchor
				referenceElement: aFromNodeElement
				relatedTo: aToNodeElement);
		toAnchor: (BlNearestPositionEllipseAnchor
				referenceElement: aToNodeElement
				relatedTo: aFromNodeElement);
		zIndex: self defaultEdgeElevationIndex;
		addAptitude: (BrGlamorousWithExplicitContextMenuAptitude
				content: [ GtWardleyMapEdgeEditorElement new
						wardleyMapViewModel: self wardleyMapViewModel;
						wardleyMapEdgeViewModel: anEdgeViewModel;
						requestFocus ])
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> createEvolveEdgeViewFor: anEvolveEdgeViewModel [
	| aFromNodeElement aToNodeElement |

	aFromNodeElement := self
		nodeViewFor: anEvolveEdgeViewModel fromNodeViewModel
		ifFound: [ :anElement | anElement ]
		ifNone: [ ^ self ].

	aToNodeElement := self
		nodeViewFor: anEvolveEdgeViewModel toNodeViewModel
		ifFound: [ :anElement | anElement ]
		ifNone: [ ^ self ].

	^ GtWardleyMapEdgeElement new
		in: [ :aLineElement | aLineElement graph beEdge ];
		id: (self newEdgeId);
		wardleyMapEdgeViewModel: anEvolveEdgeViewModel;
		fromAnchor: (BlNearestPositionEllipseAnchor referenceElement: aFromNodeElement relatedTo: aToNodeElement);
		toAnchor: (BlNearestPositionEllipseAnchor referenceElement: aToNodeElement relatedTo: aFromNodeElement);
		zIndex: -1
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> createEvolveEditorFor: aNodeViewModel [
	^ GtWardleyMapEvolveEditorElement new
		wardleyMapViewModel: self wardleyMapViewModel;
		wardleyMapNodeViewModel: aNodeViewModel
]

{ #category : #'api - wardley map view model' }
GtWardleyMapCanvasElement >> createEvolveViewFor: anEvolveViewModel [ 
	^ GtWardleyMapEvolveElement new
		wardleyMapNodeViewModel: anEvolveViewModel;
		id: (self newNodeId);
		when: BlMouseOverEvent 
		do: [ :anEvent | 
			anEvent consumed: true.
			anEvent currentTarget onHovered ];
		when: BlMouseOutEvent 
		do: [ :anEvent | 
			anEvent consumed: true.
			anEvent currentTarget onUnhovered ];
		labelElementDo: [ :aLabelElement | 
			aLabelElement 
				when: BlMouseOverEvent 
				do: [ :anEvent | 
					anEvent consumed: true.
					anEvent currentTarget aptitude foreground: (self hoverColorFrom: anEvolveViewModel labelColor) ];
				when: BlMouseOutEvent 
				do: [ :anEvent | 
					anEvent consumed: true.
					anEvent currentTarget aptitude foreground: (anEvolveViewModel labelColor) ] ];
		addEventHandler: (GtWardleyMapNodePullHandler new
				containerElement: self;
				disallowOutOfBounds;
				whenPulled: [ :aPulledElement :aNormalizedPosition | 
					anEvolveViewModel moveNodeTo: aNormalizedPosition ]);
		addEventHandler: (GtWardleyMapEdgeBuilderEventHandler new containerElement: self);
		zIndex: self defaultNodeElevationIndex;
		constraintsDo: [ :c | 
			c graph beNode ];
		in: [ :theElement |
			GtWardleyMapUtility updateNodeElement: theElement nodeViewModel: anEvolveViewModel ];
		addAptitude: (BrGlamorousWithExplicitContextMenuAptitude
				content: [ self createEvolveEditorFor: anEvolveViewModel ])
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> createNodeEditorFor: aNodeViewModel [
	^ GtWardleyMapNodeEditorElement new
		wardleyMapViewModel: self wardleyMapViewModel;
		wardleyMapNodeViewModel: aNodeViewModel;
		when: GtPhlowObjectToSpawn
			do: [ :anEvent | 
				self phlow spawnPreviousEvent: anEvent ]
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> createNodeViewFor: aNodeViewModel [
	^ GtWardleyMapNodeElement new
		wardleyMapNodeViewModel: aNodeViewModel;
		id: (self newNodeId);
		nodeElementDo: [ :anElement :aParentElement |
			anElement
				when: BlMouseOverEvent 
				do: [ :anEvent | 
					anEvent consumed: true.
					aParentElement onHovered ];
				when: BlMouseOutEvent 
				do: [ :anEvent | 
					anEvent consumed: true.
					aParentElement onUnhovered ] ];
		labelElementDo: [ :aLabelElement | 
			aLabelElement 
				when: BlMouseOverEvent 
				do: [ :anEvent | 
					anEvent consumed: true.
					anEvent currentTarget aptitude foreground: (self hoverColorFrom: aNodeViewModel labelColor) ];
				when: BlMouseOutEvent 
				do: [ :anEvent | 
					anEvent consumed: true.
					anEvent currentTarget aptitude foreground: (aNodeViewModel labelColor) ] ];
		addEventHandler: (GtWardleyMapNodePullHandler new
				containerElement: self;
				disallowOutOfBounds;
				whenPulled: [ :aPulledElement :aNormalizedPosition | 
					aNodeViewModel moveNodeTo: aNormalizedPosition ]);
		addEventHandler: (GtWardleyMapEdgeBuilderEventHandler new containerElement: self);
		zIndex: self defaultNodeElevationIndex;
		constraintsDo: [ :c | 
			c graph beNode ];
		in: [ :theElement |
			GtWardleyMapUtility updateNodeElement: theElement nodeViewModel: aNodeViewModel ];
		addAptitude: (BrGlamorousWithExplicitContextMenuAptitude
				content: [ self createNodeEditorFor: aNodeViewModel ])
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> createNoteEditorFor: aNoteViewModel [
	^ GtWardleyMapNoteEditorElement new
		wardleyMapViewModel: self wardleyMapViewModel;
		wardleyMapNoteViewModel: aNoteViewModel
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> createNoteViewFor: aNoteViewModel [
	^ GtWardleyMapNoteElement new
		wardleyMapNoteViewModel: aNoteViewModel;
		id: (self newNoteId);
		when: BlMouseOverEvent 
		do: [ :anEvent | 
			anEvent consumed: true.
			anEvent currentTarget labelElementDo: [ :aLabelElement |
				aLabelElement aptitude foreground: (self hoverColorFrom: aNoteViewModel noteColor) ] ];
		when: BlMouseOutEvent 
		do: [ :anEvent | 
			anEvent consumed: true.
			anEvent currentTarget labelElementDo: [ :aLabelElement |
				aLabelElement aptitude foreground: (aNoteViewModel noteColor) ] ];
		addEventHandler: (GtWardleyMapNotePullHandler new
				containerElement: self;
				disallowOutOfBounds;
				whenPulled: [ :aPulledElement :aNormalizedPosition | 
					aNoteViewModel moveNoteTo: aNormalizedPosition ]);
		zIndex: self defaultNoteElevationIndex;
		in: [ :theElement |
			GtWardleyMapUtility updateNoteElement: theElement noteViewModel: aNoteViewModel ];
		addAptitude: (BrGlamorousWithExplicitContextMenuAptitude
				content: [ self createNoteEditorFor: aNoteViewModel ]);
		yourself
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> createPipelineViewFor: aNodeViewModel [
	^ GtWardleyMapPipelineElement new
		wardleyMapNodeViewModel: aNodeViewModel;
		id: (self newPipelineId);
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
		addAptitude: (BrGlamorousWithExplicitContextMenuAptitude
				content: [ self createNodeEditorFor: aNodeViewModel ])
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> defaultEdgeElevationIndex [
	^ GtWardleyMapConstants edgeElevationIndex
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> defaultNodeElevationIndex [
	^ GtWardleyMapConstants nodeElevationIndex
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> defaultNoteElevationIndex [
	^ 3
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> defaultPipelineElevationIndex [
	^ GtWardleyMapConstants pipelineElevationIndex
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> draggingNodeElevationIndex [
	^ 3
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> draggingNoteElevationIndex [
	^ 3
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> draggingPipelineElevationIndex [
	^ 1
]

{ #category : #'api - wardley map view model' }
GtWardleyMapCanvasElement >> edgeViewFor: anEdgeViewModel ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self children
		detect: [ :eachChild | eachChild graph isEdge and: [ eachChild wardleyMapEdgeViewModel = anEdgeViewModel ] ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #accessing }
GtWardleyMapCanvasElement >> hoverColorFrom: aColor [
	^ GtWardleyMapConstants hoverColor
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> initialize [
	super initialize.
	
	idGenerator := BlUniqueIdGenerator new.

	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
		
	self layout: BlFrameLayout new.

	self installContextMenu.

	self
		when: BlDoubleClickEvent
		do: [ :anEvent | self onDoubleClickEvent: anEvent ].
		
	"When users click on the canvas, we want to lose focus of other elements,
	e.g., of node editable labels."
	self beFocusable.
	self
		when: BlClickEvent
		do: [ :anEvent | self onClickEvent: anEvent ].
]

{ #category : #accessing }
GtWardleyMapCanvasElement >> installContextMenu [
	self
		addAptitude: (BrGlamorousWithExplicitContextMenuAptitude
				content: [ GtWardleyMapEditorElement new
						canvas: self;
						wardleyMapViewModel: self wardleyMapViewModel;
						requestFocus ])
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> newEdgeId [
	^ #edge asBlocElementId indexed: idGenerator generateUniqueId
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> newNodeId [
	^ #node asBlocElementId indexed: idGenerator generateUniqueId
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> newNoteId [
	^ #note asBlocElementId indexed: idGenerator generateUniqueId
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> newPipelineId [
	^ #pipeline asBlocElementId indexed: idGenerator generateUniqueId
]

{ #category : #private }
GtWardleyMapCanvasElement >> nextElementId [
]

{ #category : #'api - wardley map view model' }
GtWardleyMapCanvasElement >> nodeViewFor: aNodeViewModel ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self children
		detect: [ :eachChild | eachChild graph isNode and: [ eachChild wardleyMapNodeViewModel = aNodeViewModel ] ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'api - wardley map view model' }
GtWardleyMapCanvasElement >> noteViewFor: aNoteViewModel ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self children
		detect: [ :eachChild | (eachChild isKindOf: GtWardleyMapNoteElement) and: [ eachChild wardleyMapNoteViewModel = aNoteViewModel ] ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'event handling' }
GtWardleyMapCanvasElement >> onClickEvent: anEvent [ 
	anEvent consumed: true.
	self requestFocus
]

{ #category : #'event handling' }
GtWardleyMapCanvasElement >> onDoubleClickEvent: anEvent [
	anEvent consumed: true.
	(self width isZero or: [ self height isZero ]) ifTrue: [ ^ self ].
	self wardleyMapViewModel
		addNewNodeAt: anEvent localPosition / self extent
		fromElement: self
]

{ #category : #'event handling' }
GtWardleyMapCanvasElement >> onEdgeAdded: anAnnouncement [
	BlTaskAction
		enqueueElement: self
		action: [ self addEdgeViewModel: anAnnouncement edgeViewModel ]
]

{ #category : #'event handling' }
GtWardleyMapCanvasElement >> onEdgeRemoved: anAnnouncement [
	BlTaskAction
		enqueueElement: self
		action: [ self removeEdgeViewModel: anAnnouncement edgeViewModel ]
]

{ #category : #'event handling' }
GtWardleyMapCanvasElement >> onEvolveAdded: anAnnouncement [
	BlTaskAction
		enqueueElement: self
		action: [ self addEvolveEdgeViewModel: anAnnouncement evolveEdgeViewModel ]
]

{ #category : #'event handling' }
GtWardleyMapCanvasElement >> onEvolveRemoved: anAnnouncement [
	BlTaskAction
		enqueueElement: self
		action: [ self removeEvolveEdgeViewModel: anAnnouncement evolveEdgeViewModel ]
]

{ #category : #'event handling' }
GtWardleyMapCanvasElement >> onInnerNodeAdded: anAnnouncement [
	BlTaskAction
		enqueueElement: self
		action: [ self updateInnerNodeViewModel: anAnnouncement innerNodeViewModel ]
]

{ #category : #'event handling' }
GtWardleyMapCanvasElement >> onNodeAdded: anAnnouncement [
	BlTaskAction
		enqueueElement: self
		action: [ self addNewNodeViewModel: anAnnouncement nodeViewModel ]
]

{ #category : #'event handling' }
GtWardleyMapCanvasElement >> onNodeMoved: anAnnouncement [
	BlTaskAction
		enqueueElement: self
		action: [ self updateNodeViewModel: anAnnouncement nodeViewModel ]
]

{ #category : #'api - wardley map view model' }
GtWardleyMapCanvasElement >> onNodePipelineVisibilityChanged: anAnnouncement [
	BlTaskAction
		enqueueElement: self
		action: [ self updateNodeViewModelPipeline: anAnnouncement nodeViewModel ]
]

{ #category : #'event handling' }
GtWardleyMapCanvasElement >> onNodeRemoved: anAnnouncement [
	BlTaskAction
		enqueueElement: self
		action: [ self removeNodeViewModel: anAnnouncement nodeViewModel ]
]

{ #category : #'event handling' }
GtWardleyMapCanvasElement >> onNoteAdded: anAnnouncement [
	BlTaskAction
		enqueueElement: self
		action: [ self addNoteViewModel: anAnnouncement noteViewModel ]
]

{ #category : #'event handling' }
GtWardleyMapCanvasElement >> onNoteMoved: anAnnouncement [
	BlTaskAction
		enqueueElement: self
		action: [ self updateNoteViewModel: anAnnouncement noteViewModel ]
]

{ #category : #'event handling' }
GtWardleyMapCanvasElement >> onNoteRemoved: anAnnouncement [
	BlTaskAction
		enqueueElement: self
		action: [ self removeNoteViewModel: anAnnouncement noteViewModel ]
]

{ #category : #'api - wardley map view model' }
GtWardleyMapCanvasElement >> onWardleyMapViewModelChanged [
	"Is sent when a new WardleyMap view model is assigned to the element"
	| theNodeElements theEdgeElements thePipelineElements theNoteElements theEvolveElements theEvolveEdgeElements |

	self removeChildren.
	theNodeElements := self wardleyMapViewModel nodeViewModels collect: [ :eachNodeViewModel |
		self createNodeViewFor: eachNodeViewModel ].
		
	theEvolveElements := self wardleyMapViewModel evolveViewModels collect: [ :eachEvolveViewModel | 
		self createEvolveViewFor: eachEvolveViewModel ].
	
	thePipelineElements := Array streamContents: [ :aStream |  
		self wardleyMapViewModel nodeViewModels do: [ :eachNodeViewModel | 
			eachNodeViewModel isPipelineVisible ifTrue: [ 
				aStream nextPut: (self createPipelineViewFor: eachNodeViewModel) ] ] ].
	
	self addChildren: thePipelineElements.
	self addChildren: theNodeElements.
	self addChildren: theEvolveElements.
	
	theNoteElements := self wardleyMapViewModel noteViewModels collect: [ :eachNoteViewModel |
		self createNoteViewFor: eachNoteViewModel ].
		
	self addChildren: theNoteElements.
	
	theEdgeElements := self wardleyMapViewModel edgeViewModels collect: [ :eachEdgeViewModel |
		self createEdgeViewFor: eachEdgeViewModel ].
	
	theEvolveEdgeElements := self wardleyMapViewModel evolveEdgeViewModels collect: [ :eachEvolveEdgeViewModel |
		self createEvolveEdgeViewFor: eachEvolveEdgeViewModel ].
		
	self addChildren: theEdgeElements.
	self addChildren: theEvolveEdgeElements
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

{ #category : #'private - updating' }
GtWardleyMapCanvasElement >> removeEdgeViewModel: anEdgeViewModel [
	self
		edgeViewFor: anEdgeViewModel
		ifFound: [ :anEdgeElement | anEdgeElement removeFromParent ]
		ifNone: [  ]
]

{ #category : #'private - updating' }
GtWardleyMapCanvasElement >> removeEvolveEdgeViewModel: anEvolveEdgeViewModel [
	| anEvolveViewModel |
	anEvolveViewModel := anEvolveEdgeViewModel evolveViewModel.
	self
		edgeViewFor: anEvolveEdgeViewModel
		ifFound: [ :anEvolveElement | anEvolveElement removeFromParent ]
		ifNone: [ nil ].
	self
		nodeViewFor: anEvolveViewModel
		ifFound: [ :anEvolveElement | anEvolveElement removeFromParent ]
		ifNone: [ nil ]
]

{ #category : #'private - updating' }
GtWardleyMapCanvasElement >> removeNodeViewModel: aNodeViewModel [
	self
		nodeViewFor: aNodeViewModel
		ifFound: [ :aNodeElement | aNodeElement removeFromParent ]
		ifNone: [  ]
]

{ #category : #'private - updating' }
GtWardleyMapCanvasElement >> removeNoteViewModel: aNoteViewModel [
	self
		noteViewFor: aNoteViewModel
		ifFound: [ :aNoteElement | aNoteElement removeFromParent ]
		ifNone: [  ]
]

{ #category : #'api - wardley map view model' }
GtWardleyMapCanvasElement >> subscribeToWardleyMapViewModel [
	"Is sent after a new WardleyMap view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapViewModel if elements subscribe to them"
	
	self wardleyMapViewModel weak
		when: GtWardleyMapNodeViewModelMoved send: #onNodeMoved: to: self;
		when: GtWardleyMapEvolveViewModelMoved send: #onNodeMoved: to: self;
		when: GtWardleyMapNodeViewModelAdded send: #onNodeAdded: to: self;
		when: GtWardleyMapNodeViewModelRemoved send: #onNodeRemoved: to: self;
		when: GtWardleyMapNodeViewModelPipelineVisibilityChanged send: #onNodePipelineVisibilityChanged: to: self;
		when: GtWardleyMapNodeViewModelInnerNodeAdded send: #onInnerNodeAdded: to: self;
		when: GtWardleyMapEvolveViewModelAdded send: #onEvolveAdded: to: self;
		when: GtWardleyMapEvolveViewModelRemoved send: #onEvolveRemoved: to: self;
		when: GtWardleyMapEdgeViewModelAdded send: #onEdgeAdded: to: self;
		when: GtWardleyMapEdgeViewModelRemoved send: #onEdgeRemoved: to: self;
		when: GtWardleyMapNoteViewModelMoved send: #onNoteMoved: to: self;
		when: GtWardleyMapNoteViewModelAdded send: #onNoteAdded: to: self;
		when: GtWardleyMapNoteViewModelRemoved send: #onNoteRemoved: to: self
]

{ #category : #'api - wardley map view model' }
GtWardleyMapCanvasElement >> unsubscribeFromWardleyMapViewModel [
	"Is sent before a new WardleyMap view model is assigned to the element.
	Elements that subscribe to WardleyMap view model in domain model are required to implement this methods"
	
	self wardleyMapViewModel unsubscribe: self
]

{ #category : #'private - updating' }
GtWardleyMapCanvasElement >> updateInnerNodeViewModel: anInnerNodeViewModel [
	| aPipelineNodeViewModel |
	aPipelineNodeViewModel := anInnerNodeViewModel pipelineNodeViewModel.

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

{ #category : #'private - updating' }
GtWardleyMapCanvasElement >> updateNodeViewModel: aMovedNodeViewModel [
	self
		nodeViewFor: aMovedNodeViewModel
		ifFound: [ :aNodeView | 
			GtWardleyMapUtility
				updateNodeElement: aNodeView
				nodeViewModel: aMovedNodeViewModel ]
		ifNone: [  ].

	aMovedNodeViewModel isPipelineVisible
		ifTrue: [ self
				pipelineViewFor: aMovedNodeViewModel
				ifFound: [ :aPipelineView | 
					GtWardleyMapUtility
						updatePipelineElement: aPipelineView
						nodeViewModel: aMovedNodeViewModel ]
				ifNone: [  ] ]
]

{ #category : #'private - updating' }
GtWardleyMapCanvasElement >> updateNodeViewModelPipeline: aChangedNodeViewModel [
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

{ #category : #'private - updating' }
GtWardleyMapCanvasElement >> updateNoteViewModel: aMovedNoteViewModel [
	self
		noteViewFor: aMovedNoteViewModel
		ifFound: [ :aNoteView | 
			GtWardleyMapUtility
				updateNoteElement: aNoteView
				noteViewModel: aMovedNoteViewModel ]
		ifNone: [  ]
]
