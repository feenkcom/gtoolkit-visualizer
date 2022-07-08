Class {
	#name : #GtSequenceDiagramSelfMessageNodeElement,
	#superclass : #BrFrame,
	#traits : 'TGtWithSequenceDiagramMessageViewModel',
	#classTraits : 'TGtWithSequenceDiagramMessageViewModel classTrait',
	#instVars : [
		'labelElement',
		'messageContainer',
		'arrowOne',
		'arrowTwo',
		'arrowThree'
	],
	#category : #'GToolkit-SequenceDiagram-UI'
}

{ #category : #initialization }
GtSequenceDiagramSelfMessageNodeElement >> defaultArrowBorder [
	^ BlBorder
		paint: GtSequenceDiagramUtility messageSendLineDefaultBackgroundColor
		width: GtSequenceDiagramUtility messageLineWidth
]

{ #category : #initialization }
GtSequenceDiagramSelfMessageNodeElement >> defaultColor [
	^ GtSequenceDiagramUtility messageSendLineDefaultBackgroundColor
]

{ #category : #initialization }
GtSequenceDiagramSelfMessageNodeElement >> defaultMessageContainerHeight [
	^ GtSequenceDiagramUtility verticalLineSegmetHeight - 8
]

{ #category : #initialization }
GtSequenceDiagramSelfMessageNodeElement >> defaultMessageContainerWidth [
	^ GtSequenceDiagramUtility verticalLineWidth + (2 * 36)
]

{ #category : #initialization }
GtSequenceDiagramSelfMessageNodeElement >> defaultWidth [
	^ 1
]

{ #category : #testing }
GtSequenceDiagramSelfMessageNodeElement >> hasInspecteableModel [
	^ self hasMessageViewModel and: [ self messageViewModel hasModel ]
]

{ #category : #initialization }
GtSequenceDiagramSelfMessageNodeElement >> hoveredArrowBorder [
	^ BlBorder
		paint: GtSequenceDiagramUtility hoveredBackgroundColor
		width: GtSequenceDiagramUtility messageLineWidth
]

{ #category : #initialization }
GtSequenceDiagramSelfMessageNodeElement >> initialize [
	super initialize.
	self initializeChildren.
	self initializeStyle.
	self initializeEventHandlers.

	self styleDefault.
	self hFitContent.
	self vExact: GtSequenceDiagramUtility verticalLineSegmetHeight.
	self background: BlBackground transparent.
	self clipChildren: false.

	self constraintsDo: [ :c | c grid horizontal alignCenter ]
]

{ #category : #initialization }
GtSequenceDiagramSelfMessageNodeElement >> initializeChildren [
	| anObjectLine aLeftTop aRightTop aLeftBottom aRightBottom |
	anObjectLine := BrFrame new.
	anObjectLine
		hExact: GtSequenceDiagramUtility verticalLineWidth;
		vMatchParent;
		background: GtSequenceDiagramUtility verticalLineDefaultBackgroundColor;
		constraintsDo: [ :c | 
			c frame horizontal alignCenter.
			c frame vertical alignCenter ].

	messageContainer := BrFrame new.
	messageContainer
		hExact: self defaultMessageContainerWidth;
		vExact: self defaultMessageContainerHeight;
		background: BlBackground transparent;
		constraintsDo: [ :c | 
			c frame horizontal alignCenter.
			c frame vertical alignCenter ];
		clipChildren: false.

	messageContainer
		addChild: (aLeftTop := BlElement new
					size: (GtSequenceDiagramUtility verticalLineWidth + 2) @ 1;
					visibility: BlVisibility hidden;
					constraintsDo: [ :c | 
						c frame horizontal alignCenter.
						c frame vertical alignTop ]);
		addChild: (aRightTop := BlElement new
					size: 1 @ 1;
					visibility: BlVisibility hidden;
					constraintsDo: [ :c | 
						c frame horizontal alignRight.
						c frame vertical alignTop ]);
		addChild: (aRightBottom := BlElement new
					size: (GtSequenceDiagramUtility verticalLineWidth + 2) @ 1;
					visibility: BlVisibility hidden;
					constraintsDo: [ :c | 
						c frame horizontal alignRight.
						c frame vertical alignBottom ]);
		addChild: (aLeftBottom := BlElement new
					size: 1 @ 1;
					visibility: BlVisibility hidden;
					constraintsDo: [ :c | 
						c frame horizontal alignCenter.
						c frame vertical alignBottom ]).

	arrowOne := BlLineElement new
			border: self defaultArrowBorder;
			fromAnchor: (BlNearestPositionBoundsAnchor referenceElement: aLeftTop relatedTo: aRightTop);
			toAnchor: (BlNearestPositionBoundsAnchor referenceElement: aRightTop relatedTo: aLeftTop);
			clipChildren: false.

	arrowTwo := BlLineElement new
			border: (BlBorder
					paint: GtSequenceDiagramUtility messageSendLineDefaultBackgroundColor
					width: GtSequenceDiagramUtility messageLineWidth);
			fromAnchor: (BlNearestPositionBoundsAnchor
					referenceElement: aRightTop
					relatedTo: aRightBottom);
			toAnchor: (BlNearestPositionBoundsAnchor
					referenceElement: aRightBottom
					relatedTo: aRightTop);
			clipChildren: false.

	arrowThree := BlLineElement new
			border: (BlBorder
					paint: GtSequenceDiagramUtility messageSendLineDefaultBackgroundColor
					width: GtSequenceDiagramUtility messageLineWidth);
			fromAnchor: (BlNearestPositionBoundsAnchor
					referenceElement: aRightBottom
					relatedTo: aLeftBottom);
			toAnchor: (BlNearestPositionBoundsAnchor
					referenceElement: aLeftBottom
					relatedTo: aRightBottom);
			toHead: (BlArrowheadTriangle new
					background: GtSequenceDiagramUtility messageSendLineDefaultBackgroundColor;
					scale: 3;
					border: (BlBorder
							paint: GtSequenceDiagramUtility messageSendLineDefaultBackgroundColor
							width: GtSequenceDiagramUtility messageLineWidth));
			clipChildren: false.

	labelElement := GtSequenceDiagramUtility newMessageLabel
			constraintsDo: [ :c | 
				c ignoreByLayout.
				c ignored horizontal alignRightAt: 1.6.
				c ignored vertical alignCenter ].

	messageContainer
		addChild: arrowOne;
		addChild: arrowTwo;
		addChild: arrowThree;
		addChild: labelElement.

	self
		addChild: anObjectLine;
		addChild: messageContainer
]

{ #category : #initialization }
GtSequenceDiagramSelfMessageNodeElement >> initializeEventHandlers [
	self when: BlClickEvent do: [ :anEvent | self onMouseClick: anEvent ]
]

{ #category : #initialization }
GtSequenceDiagramSelfMessageNodeElement >> initializeStyle [
	self
		aptitude: (BrStyleCommonAptitude new
				hovered: [ :aStyle | aStyle do: [ self styleHovered ] after: [ self styleDefault ] ])
]

{ #category : #'api - message view model' }
GtSequenceDiagramSelfMessageNodeElement >> onMessageViewModelChanged [
	self updateElement
]

{ #category : #'private - event handling' }
GtSequenceDiagramSelfMessageNodeElement >> onMouseClick: anEvent [
	self hasInspecteableModel ifFalse: [ ^ self ].

	self phlow spawnObject: self messageViewModel model
]

{ #category : #'private - styling' }
GtSequenceDiagramSelfMessageNodeElement >> styleDefault [
	labelElement aptitude
		foreground: GtSequenceDiagramUtility messageLabelDefaultForegroudColor.

	arrowOne border: self defaultArrowBorder.
	arrowTwo border: self defaultArrowBorder.
	arrowThree border: self defaultArrowBorder.
	arrowThree toHead
		background: GtSequenceDiagramUtility messageSendLineDefaultBackgroundColor;
		border: self defaultArrowBorder
]

{ #category : #'private - styling' }
GtSequenceDiagramSelfMessageNodeElement >> styleHovered [
	self hasInspecteableModel ifFalse: [ ^ self ].

	labelElement aptitude
		foreground: GtSequenceDiagramUtility hoveredBackgroundColor.

	arrowOne border: self hoveredArrowBorder.
	arrowTwo border: self hoveredArrowBorder.
	arrowThree border: self hoveredArrowBorder.
	arrowThree toHead
		background: GtSequenceDiagramUtility hoveredBackgroundColor;
		border: self hoveredArrowBorder
]

{ #category : #'private - updating' }
GtSequenceDiagramSelfMessageNodeElement >> updateElement [
	| aName |
	aName := self messageViewModel name asString.
	labelElement text: aName.

	aName size < 15
		ifTrue: [ messageContainer hExact: self defaultMessageContainerWidth ]
		ifFalse: [ | anExtraWidth |
			anExtraWidth := (aName size - 15).
			messageContainer hExact: self defaultMessageContainerWidth + anExtraWidth ]
]
