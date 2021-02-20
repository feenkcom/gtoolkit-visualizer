Class {
	#name : #GtWardleyMapCanvasElement,
	#superclass : #BlCanvassableElement,
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
		fromAnchor: (BlNearestPositionEllipseAnchor referenceElement: aFromNodeElement relatedTo: aToNodeElement);
		toAnchor: (BlNearestPositionEllipseAnchor referenceElement: aToNodeElement relatedTo: aFromNodeElement);
		zIndex: -1;
		addLook: (BrGlamorousWithDropdownLook
			handle: [ BlElement new
					size: 10@10;
					geometry: BlEllipseGeometry new;
					background: anEdgeViewModel lineColor ]
			content: [ GtWardleyMapEdgeEditorElement new
				wardleyMapViewModel: self wardleyMapViewModel;
				wardleyMapEdgeViewModel: anEdgeViewModel;
				requestFocus ]) onPrimaryClick doNotHideWidget attachToCenter
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> createNodeViewFor: aNodeViewModel [
	^ GtWardleyMapNodeElement new
		wardleyMapNodeViewModel: aNodeViewModel;
		addEventHandler: (GtWardleyMapPullHandler new
			containerElement: self;
			whenPulled: [ :aPulledElement :aNormalizedPosition | aNodeViewModel moveNodeTo: aNormalizedPosition ]);
		addEventHandler: (GtWardleyMapEdgeBuilder new containerElement: self);
		constraintsDo: [ :c |
			c frame horizontal alignCenterAt: aNodeViewModel coordinateX.
			c frame vertical alignCenterAt: aNodeViewModel coordinateY.
			c graph beNode ];
		addLook: (BrGlamorousWithDropdownLook
			handle: [ BlElement new
					size: aNodeViewModel extent;
					geometry: BlEllipseGeometry new;
					background: aNodeViewModel nodeColor ]
			content: [ GtWardleyMapNodeEditorElement new
				wardleyMapViewModel: self wardleyMapViewModel;
				wardleyMapNodeViewModel: aNodeViewModel ]) onPrimaryClick doNotHideWidget
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

	self
		when: BlDoubleClickEvent
		do: [ :anEvent |
			anEvent consumed: true.
			(self width isZero or: [ self height isZero ])
				ifFalse: [ self wardleyMapViewModel addNewNodeAt: anEvent localPosition / self extent ] ]
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
			aNodeView constraintsDo: [ :c |
				c frame horizontal alignCenterAt: aMovedNodeViewModel coordinateX.
				c frame vertical alignCenterAt: aMovedNodeViewModel coordinateY ] ]
		ifNone: [  ]
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
	| theNodeElements theEdgeElements |

	self removeChildren.
	theNodeElements := self wardleyMapViewModel nodeViewModels collect: [ :eachNodeViewModel |
		self createNodeViewFor: eachNodeViewModel ].
	
	self addChildren: theNodeElements.
	
	theEdgeElements := self wardleyMapViewModel edgeViewModels collect: [ :eachEdgeViewModel |
		self createEdgeViewFor: eachEdgeViewModel ].

	self addChildren: theEdgeElements.
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
		when: GtWardleyMapEdgeViewModelAdded send: #onEdgeAdded: to: self;
		when: GtWardleyMapEdgeViewModelRemoved send: #onEdgeRemoved: to: self
]

{ #category : #'api - wardley map view model' }
GtWardleyMapCanvasElement >> unsubscribeFromWardleyMapViewModel [
	"Is sent before a new WardleyMap view model is assigned to the element.
	Elements that subscribe to WardleyMap view model in domain model are required to implement this methods"
	
	self wardleyMapViewModel unsubscribe: self
]
