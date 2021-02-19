Class {
	#name : #GtWardleyMapCanvasElement,
	#superclass : #BlCanvassableElement,
	#traits : 'TGtWithWardleyMapViewModel',
	#classTraits : 'TGtWithWardleyMapViewModel classTrait',
	#instVars : [
		'predefinedColors',
		'defaultColor'
	],
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #adding }
GtWardleyMapCanvasElement >> addNodeAt: aRelativePosition [
	| aNodeElement |

	aNodeElement := self createCircleNode.
	aNodeElement addEventHandler: BlPullHandler new.
	aNodeElement when: BlPullStartEvent do: [ :anEvent |
		anEvent currentTarget relocate: anEvent currentTarget position ].
	aNodeElement when: BlPullEvent do: [ :anEvent |
		| newRelativePosition |

		newRelativePosition := (anEvent newPosition + (self circleNodeExtent / 2.0)) / self extent.

		anEvent currentTarget constraintsDo: [ :c |
			c frame horizontal alignCenterAt: newRelativePosition x.
			c frame vertical alignCenterAt: newRelativePosition y ] ].

	aNodeElement constraintsDo: [ :c |
		c frame horizontal alignCenterAt: aRelativePosition x.
		c frame vertical alignCenterAt: aRelativePosition y ].

	self addChild: aNodeElement
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> circleNodeExtent [
	^ 12@12
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> createCircleNode [
	| aCircleNode aNodeLabel |

	aCircleNode := BlElement new
		size: self circleNodeExtent;
		geometry: BlEllipseGeometry new;
		background: defaultColor;
		clipChildren: false.

	aNodeLabel := BrEditableLabel new
		look: (BrGlamorousRegularEditorLook new foreground: defaultColor darker);
		text: 'Label'.
	
	"we have to wrap the editable label in a pullable element to allow text selection with drag"
	aCircleNode addChild: (BrHorizontalPane new
		fitContent;
		addEventHandler: BlPullHandler new;
		relocate: self circleNodeExtent + (26 negated @ 0);
		addChild: aNodeLabel).

	aCircleNode addLook: (BrGlamorousWithDropdownLook
		handle: [ BlElement new
				size: self circleNodeExtent;
				geometry: BlEllipseGeometry new;
				background: aCircleNode background ]
		content: [ self createColorPickerAndThen: [ :aColor |
				aCircleNode background: aColor.
				aNodeLabel look foreground: aColor darker.
				defaultColor := aColor ] ]) onPrimaryClick.

	aCircleNode addLook: (BrStyleCommonLook new
		focused: [ :s | s border: (BlBorder paint: (BrGlamorousColors focusedEditorBorderColor) width: 1) ]).

	aCircleNode when: BlClickEvent do: [ :anEvent |
		(anEvent modifiers isPrimaryModifier not and: [ anEvent target = self ])
			ifTrue: [
				anEvent consumed: true.
				aCircleNode requestFocus ] ].

	aCircleNode addShortcut: (BlShortcutWithAction new
		combination: BlKeyCombination backspace;
		action: [ :anEvent | anEvent currentTarget removeFromParent ]).

	^ aCircleNode
]

{ #category : #initialization }
GtWardleyMapCanvasElement >> createColorPickerAndThen: aCallbackBlock [
	| aContainer theColorsPane thePredefinedColors |
	
	aContainer := BrVerticalPane new
		hFitContent;
		vFitContentLimited;
		padding: (BlInsets all: 3).

	theColorsPane := BrVerticalPane new
		hFitContent
		vFitContentLimited.

	thePredefinedColors := BrHorizontalGrid new
		hFitContent;
		vFitContentLimited;
		columnCount: 8.

	thePredefinedColors addChildren: (predefinedColors collect: [ :eachColor |
		BlElement new
			size: 16@16;
			margin: (BlInsets all: 3);
			background: eachColor;
			border: (eachColor luminance >= Color lightGray luminance
				ifTrue: [ BlBorder paint: Color darkGray width: 1 ]
				ifFalse: [ BlBorder empty ]);
			geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
			when: BlClickEvent do: [ :anEvent |
				anEvent consumed: true.
				anEvent currentTarget fireEvent: (BrDropdownHideWish new).
				aCallbackBlock value: eachColor ] ]).
	
	theColorsPane addChildren: { thePredefinedColors }.
	
	aContainer addChild: (BrScrollPane new
		look: BrScrollPaneLook + BrGlamorousWithVerticalScrollbarLook;
		vFitContentLimited;
		hFitContent;
		content: theColorsPane).
	
	^ aContainer
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
				ifFalse: [ self addNodeAt: anEvent localPosition / self extent ] ].

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
	
	defaultColor := Color gray
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

{ #category : #'api - wardley map view model' }
GtWardleyMapCanvasElement >> onWardleyMapViewModelChanged [
	"Is sent when a new WardleyMap view model is assigned to the element"
	| theNodeElements |

	self removeChildren.
	theNodeElements := self wardleyMapViewModel nodeViewModels collect: [ :eachNodeViewModel |
		GtWardleyMapNodeElement new
			wardleyMapNodeViewModel: eachNodeViewModel;
			addEventHandler: (GtWardleyMapPullHandler new
				containerElement: self;
				whenPulled: [ :aPulledElement :aNormalizedPosition | eachNodeViewModel moveNodeTo: aNormalizedPosition ]);
			constraintsDo: [ :c |
				c frame horizontal alignCenterAt: eachNodeViewModel coordinateX.
				c frame vertical alignCenterAt: eachNodeViewModel coordinateY ] ].
	
	self addChildren: theNodeElements
]

{ #category : #'api - wardley map view model' }
GtWardleyMapCanvasElement >> subscribeToWardleyMapViewModel [
	"Is sent after a new WardleyMap view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapViewModel if elements subscribe to them"
	
	self wardleyMapViewModel weak when: GtWardleyMapNodeViewModelMoved send: #onNodeMoved: to: self
]

{ #category : #'api - wardley map view model' }
GtWardleyMapCanvasElement >> unsubscribeFromWardleyMapViewModel [
	"Is sent before a new WardleyMap view model is assigned to the element.
	Elements that subscribe to WardleyMap view model in domain model are required to implement this methods"
	
	self wardleyMapViewModel unsubscribe: self
]
