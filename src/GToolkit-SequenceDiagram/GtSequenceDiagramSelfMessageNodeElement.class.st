Class {
	#name : #GtSequenceDiagramSelfMessageNodeElement,
	#superclass : #BrFrame,
	#traits : 'TGtWithSequenceDiagramMessageViewModel',
	#classTraits : 'TGtWithSequenceDiagramMessageViewModel classTrait',
	#instVars : [
		'labelElement',
		'messageContainer'
	],
	#category : #'GToolkit-SequenceDiagram-UI'
}

{ #category : #initialization }
GtSequenceDiagramSelfMessageNodeElement >> defaultColor [
	^ Color black
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

{ #category : #initialization }
GtSequenceDiagramSelfMessageNodeElement >> initialize [
	super initialize.
	self initializeChildren.

	self hFitContent.
	self vExact: GtSequenceDiagramUtility verticalLineSegmetHeight.
	self background: BlBackground transparent.
	self clipChildren: false.

	self constraintsDo: [ :c | c grid horizontal alignCenter ]
]

{ #category : #initialization }
GtSequenceDiagramSelfMessageNodeElement >> initializeChildren [
	| anObjectLine aLeftTop aRightTop aLeftBottom aRightBottom anArrowOne anArrowTwo anArrowThree |
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

	anArrowOne := BlLineElement new
			border: (BlBorder
					paint: GtSequenceDiagramUtility messageSendLineDefaultBackgroundColor
					width: GtSequenceDiagramUtility messageLineWidth);
			fromAnchor: (BlNearestPositionBoundsAnchor referenceElement: aLeftTop relatedTo: aRightTop);
			toAnchor: (BlNearestPositionBoundsAnchor referenceElement: aRightTop relatedTo: aLeftTop);
			clipChildren: false.

	anArrowTwo := BlLineElement new
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

	anArrowThree := BlLineElement new
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
					background: self defaultColor;
					scale: 3;
					border: (BlBorder paint: self defaultColor width: 1));
			clipChildren: false.

	labelElement := GtSequenceDiagramUtility newMessageLabel
			constraintsDo: [ :c | 
				c ignoreByLayout.
				c ignored horizontal alignRightAt: 1.6.
				c ignored vertical alignCenter ].

	messageContainer
		addChild: anArrowOne;
		addChild: anArrowTwo;
		addChild: anArrowThree;
		addChild: labelElement.

	self
		addChild: anObjectLine;
		addChild: messageContainer
]

{ #category : #'api - message view model' }
GtSequenceDiagramSelfMessageNodeElement >> onMessageViewModelChanged [
	self updateElement
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
