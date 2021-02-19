Class {
	#name : #GtWardleyMapCanvasElement,
	#superclass : #BlCanvassableElement,
	#traits : 'TGtWithWardleyMapViewModel',
	#classTraits : 'TGtWithWardleyMapViewModel classTrait',
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #initialization }
GtWardleyMapCanvasElement >> createNodeViewFor: aNodeViewModel [
	^ GtWardleyMapNodeElement new
		wardleyMapNodeViewModel: aNodeViewModel;
		addEventHandler: (GtWardleyMapPullHandler new
			containerElement: self;
			whenPulled: [ :aPulledElement :aNormalizedPosition | aNodeViewModel moveNodeTo: aNormalizedPosition ]);
		constraintsDo: [ :c |
			c frame horizontal alignCenterAt: aNodeViewModel coordinateX.
			c frame vertical alignCenterAt: aNodeViewModel coordinateY ];
		addLook: (BrGlamorousWithDropdownLook
			handle: [ BlElement new
					size: aNodeViewModel extent;
					geometry: BlEllipseGeometry new;
					background: aNodeViewModel nodeColor ]
			content: [ GtWardleyMapNodeEditorElement new
				wardleyMapViewModel: self wardleyMapViewModel;
				wardleyMapNodeViewModel: aNodeViewModel ]) onPrimaryClick
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
		detect: [ :eachChild | eachChild wardleyMapNodeViewModel = aNodeViewModel ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'event handling' }
GtWardleyMapCanvasElement >> onNodeAdded: anAnnouncement [

	self addChild: (self createNodeViewFor: anAnnouncement nodeViewModel)
]

{ #category : #'event handling' }
GtWardleyMapCanvasElement >> onNodeMoved: anAnnouncement [
	| aMovedNodeViewModel |
	
	aMovedNodeViewModel := anAnnouncement nodeViewModel.
	self children
		detect: [ :eachNodeView | eachNodeView wardleyMapNodeViewModel = aMovedNodeViewModel ]
		ifFound: [ :aNodeView |
			aNodeView constraintsDo: [ :c |
				c frame horizontal alignCenterAt: aMovedNodeViewModel coordinateX.
				c frame vertical alignCenterAt: aMovedNodeViewModel coordinateY ] ]
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
	| theNodeElements |

	self removeChildren.
	theNodeElements := self wardleyMapViewModel nodeViewModels collect: [ :eachNodeViewModel |
		self createNodeViewFor: eachNodeViewModel ].

	self addChildren: theNodeElements
]

{ #category : #'api - wardley map view model' }
GtWardleyMapCanvasElement >> subscribeToWardleyMapViewModel [
	"Is sent after a new WardleyMap view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapViewModel if elements subscribe to them"
	
	self wardleyMapViewModel weak
		when: GtWardleyMapNodeViewModelMoved send: #onNodeMoved: to: self;
		when: GtWardleyMapNodeViewModelAdded send: #onNodeAdded: to: self;
		when: GtWardleyMapNodeViewModelRemoved send: #onNodeRemoved: to: self
]

{ #category : #'api - wardley map view model' }
GtWardleyMapCanvasElement >> unsubscribeFromWardleyMapViewModel [
	"Is sent before a new WardleyMap view model is assigned to the element.
	Elements that subscribe to WardleyMap view model in domain model are required to implement this methods"
	
	self wardleyMapViewModel unsubscribe: self
]
