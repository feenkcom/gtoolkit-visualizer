Class {
	#name : #GtWardleyMapEdgeElement,
	#superclass : #BlLineElement,
	#traits : 'TGtWithWardleyMapEdgeViewModel',
	#classTraits : 'TGtWithWardleyMapEdgeViewModel classTrait',
	#instVars : [
		'labelElement',
		'labelContainer'
	],
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #private }
GtWardleyMapEdgeElement >> createDefaultBorder [
	^ BlBorder builder
		paint: self wardleyMapEdgeViewModel lineColor;
		width: self wardleyMapEdgeViewModel lineWidth;
		in: [ :aBuilder | 
			self wardleyMapEdgeViewModel isEvolveEdgeViewModel
				ifTrue: [ aBuilder dashed ] ];
		build
]

{ #category : #private }
GtWardleyMapEdgeElement >> createHoveredBorder [
	^ BlBorder builder
		paint: GtWardleyMapConstants hoverColor;
		width: self wardleyMapEdgeViewModel lineWidth;
		in: [ :aBuilder | 
			self wardleyMapEdgeViewModel isEvolveEdgeViewModel
				ifTrue: [ aBuilder dashed ] ];
		build
]

{ #category : #initialization }
GtWardleyMapEdgeElement >> initialize [
	super initialize.
	self clipChildren: false.
	self aptitude: (BrStyleCommonAptitude new
			focused: [ :s | s border: (BlBorder paint: self theme editor focusedBorderColor width: 1) ]).
	labelElement := BrEditableLabel new
			fitContent;
			id: GtWardleyMapNodeLabelId;
			aptitude: BrGlamorousRegularEditorAptitude new;
			when: BrEditorAcceptWish
				do: [ :aWish | self wardleyMapEdgeViewModel label: aWish text asString ];
			text: 'Edge label'.
			
	"we have to wrap the editable label in a pullable element to allow text selection with drag"
	labelContainer := BrHorizontalPane new
			fitContent;
			addEventHandler: (GtWardleyMapPullHandler new
					containerElement: self;
					allowOutOfBounds;
					whenPulled: [ :aPulledElement :aNormalizedPosition | 
						self wardleyMapEdgeViewModel moveEdgeLabelTo: aNormalizedPosition ]);
			addChild: labelElement.
	self addChild: labelContainer.
	
	self
		when: BlClickEvent
		do: [ :anEvent | 
			(anEvent modifiers isPrimaryModifier not
				and: [ anEvent target = anEvent currentTarget ])
				ifTrue: [ anEvent consumed: true.
					anEvent currentTarget requestFocus ] ].
	self
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination backspace;
				action: [ self wardleyMapEdgeViewModel removeFromMap ]).
	self
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination builder primary minus build;
				action: [ self wardleyMapEdgeViewModel decreaseWidth ]).
	self
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination builder primary equal build;
				action: [ self wardleyMapEdgeViewModel increaseWidth ])
]

{ #category : #accessing }
GtWardleyMapEdgeElement >> labelContainerDo: aBlock [
	aBlock value: labelContainer
]

{ #category : #accessing }
GtWardleyMapEdgeElement >> labelElementDo: aBlock [
	aBlock value: labelElement
]

{ #category : #'event handling' }
GtWardleyMapEdgeElement >> onEdgeArrowChanged: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self updateLineArrow ]
]

{ #category : #'event handling' }
GtWardleyMapEdgeElement >> onEdgeColored: anAnnouncement [
	BlTaskAction
		enqueueElement: self
		action: [ 
			self updateLineLook.
			self updateLineArrow ]
]

{ #category : #'event handling' }
GtWardleyMapEdgeElement >> onEdgeLabelMoved [
	labelContainer constraintsDo: [ :c | 
		c frame horizontal alignCenterAt: self wardleyMapEdgeViewModel labelCoordinateX.
		c frame vertical alignCenterAt: self wardleyMapEdgeViewModel labelCoordinateY ]
]

{ #category : #'event handling' }
GtWardleyMapEdgeElement >> onEdgeLabelMoved: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onEdgeLabelMoved ]
]

{ #category : #'event handling' }
GtWardleyMapEdgeElement >> onEdgeLabelTextChanged [
	labelElement text: self wardleyMapEdgeViewModel label
]

{ #category : #'event handling' }
GtWardleyMapEdgeElement >> onEdgeLabelTextChanged: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onEdgeLabelTextChanged ]
]

{ #category : #'event handling' }
GtWardleyMapEdgeElement >> onEdgeLabelVisiblityChanged [
	self wardleyMapEdgeViewModel isLabelVisible
		ifTrue: [ labelContainer visibility: BlVisibility visible ]
		ifFalse: [ labelContainer visibility: BlVisibility gone ]
]

{ #category : #'event handling' }
GtWardleyMapEdgeElement >> onEdgeLabelVisiblityChanged: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onEdgeLabelVisiblityChanged ]
]

{ #category : #'event handling' }
GtWardleyMapEdgeElement >> onEdgeResized: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self updateLineLook ]
]

{ #category : #'api - wardley map edge view model' }
GtWardleyMapEdgeElement >> onWardleyMapEdgeViewModelChanged [
	"Is sent when a new wardleyMapEdge view model is assigned to the element"
	
	self updateLineLook.
	self updateLineArrow.
	
	self onEdgeLabelVisiblityChanged.
	self onEdgeLabelTextChanged.
	self onEdgeLabelMoved.
]

{ #category : #'api - wardley map edge view model' }
GtWardleyMapEdgeElement >> subscribeToWardleyMapEdgeViewModel [
	"Is sent after a new wardleyMapEdge view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapEdgeViewModel if elements subscribe to them"
	
	self wardleyMapEdgeViewModel weak
		when: GtWardleyMapEdgeViewModelLabelMoved send: #onEdgeLabelMoved: to: self;
		when: GtWardleyMapEdgeViewModelLabelTextChanged send: #onEdgeLabelTextChanged: to: self;
		when: GtWardleyMapEdgeViewModelLabelVisibilityChanged send: #onEdgeLabelVisiblityChanged:  to: self;
		when: GtWardleyMapEdgeViewModelResized send: #onEdgeResized: to: self;
		when: GtWardleyMapEdgeViewModelColored send: #onEdgeColored: to: self;
		when: GtWardleyMapEdgeViewModelArrowChanged send: #onEdgeArrowChanged: to: self.
]

{ #category : #'api - wardley map edge view model' }
GtWardleyMapEdgeElement >> unsubscribeFromWardleyMapEdgeViewModel [
	"Is sent before a new wardleyMapEdge view model is assigned to the element.
	Elements that subscribe to wardleyMapEdge view model in domain model are required to implement this methods"
	
	self wardleyMapEdgeViewModel unsubscribe: self
]

{ #category : #private }
GtWardleyMapEdgeElement >> updateLineArrow [

	self toHead: (self wardleyMapEdgeViewModel hasLineArrow
		ifTrue: [
			BlArrowheadSimpleArrow new
				arrowLengthFraction: 4;
				arrowNoseAngle: 50;
				background: (self wardleyMapEdgeViewModel lineColor) ]
		ifFalse: [ BlArrowheadNone new ])
]

{ #category : #private }
GtWardleyMapEdgeElement >> updateLineLook [
	self aptitude
		default: [ :aStyle | aStyle border: self createDefaultBorder ];
		hovered: [ :aStyle | 
			aStyle
				do: [ :theElement | 
					theElement border: self createHoveredBorder.
					theElement toHead ifNotNil: [ :aHead | 
						aHead background: GtWardleyMapConstants hoverColor ].
					theElement labelElementDo: [ :aLabel | 
						aLabel aptitude foreground: GtWardleyMapConstants hoverColor ] ]
				after: [ :theElement | 
					theElement border: self createDefaultBorder.
					theElement toHead ifNotNil: [ :aHead | 
						aHead background: self wardleyMapEdgeViewModel lineColor ].
					theElement labelElementDo: [ :aLabel | 
						aLabel aptitude foreground: self wardleyMapEdgeViewModel labelColor ] ] ];
		propagateStylesToWidget
]
