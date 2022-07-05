Class {
	#name : #GtSequenceDiagramSelfMessageNodeElement,
	#superclass : #BrVerticalPane,
	#traits : 'TGtWithSequenceDiagramMessageViewModel',
	#classTraits : 'TGtWithSequenceDiagramMessageViewModel classTrait',
	#instVars : [
		'labelElement'
	],
	#category : #'GToolkit-SequenceDiagram-UI'
}

{ #category : #accessing }
GtSequenceDiagramSelfMessageNodeElement >> anchorElement [

	^ container
]

{ #category : #initialization }
GtSequenceDiagramSelfMessageNodeElement >> defaultColor [
	^ Color black
]

{ #category : #initialization }
GtSequenceDiagramSelfMessageNodeElement >> defaultWidth [
	^ 1
]

{ #category : #initialization }
GtSequenceDiagramSelfMessageNodeElement >> initialize [
	super initialize.
	self initializeChildren.

	self fitContent.
	self background: BlBackground transparent.
	self clipChildren: false.

	self constraintsDo: [ :c | c grid horizontal alignCenter ]
]

{ #category : #initialization }
GtSequenceDiagramSelfMessageNodeElement >> initializeChildren [
	| aLineOne aLineThree aLeftTop aRightTop aLeftBottom aRightBottom anArrowOne anArrowTwo anArrowThree aContainer |
	aLineOne := BlElement new.
	aLineOne
		size: self defaultWidth @ 7;
		background: Color lightGray;
		constraintsDo: [ :c | c linear horizontal alignCenter ].

	aContainer := BrHorizontalPane new.
	aContainer
		exact: (self defaultWidth + (2 * 36)) @ 14;
		background: BlBackground transparent;
		constraintsDo: [ :c | c linear horizontal alignCenter ];
		clipChildren: false.

	aContainer
		addChild: (BrFrame new
				matchParent;
				background: BlBackground transparent).

	aContainer
		addChild: (BrFrame new
				vMatchParent;
				hExact: self defaultWidth;
				background: Color lightGray;
				constraintsDo: [ :c | c linear horizontal alignCenter ]).

	aContainer
		addChild: (BrFrame new
				matchParent;
				addChild: (aLeftTop := BlElement new
							size: 1 @ 1;
							constraintsDo: [ :c | 
								c frame horizontal alignLeft.
								c frame vertical alignTop ]);
				addChild: (aRightTop := BlElement new
							size: 1 @ 1;
							constraintsDo: [ :c | 
								c frame horizontal alignRight.
								c frame vertical alignTop ]);
				addChild: (aLeftBottom := BlElement new
							size: 1 @ 1;
							constraintsDo: [ :c | 
								c frame horizontal alignLeft.
								c frame vertical alignBottom ]);
				addChild: (aRightBottom := BlElement new
							size: 1 @ 1;
							constraintsDo: [ :c | 
								c frame horizontal alignRight.
								c frame vertical alignBottom ])).

	anArrowOne := BlLineElement new
			border: (BlBorder paint: self defaultColor width: 1);
			fromAnchor: (BlNearestPositionBoundsAnchor referenceElement: aLeftTop relatedTo: aRightTop);
			toAnchor: (BlNearestPositionBoundsAnchor referenceElement: aRightTop relatedTo: aLeftTop);
			clipChildren: false.

	anArrowTwo := BlLineElement new
			border: (BlBorder paint: self defaultColor width: 1);
			fromAnchor: (BlNearestPositionBoundsAnchor
					referenceElement: aRightTop
					relatedTo: aRightBottom);
			toAnchor: (BlNearestPositionBoundsAnchor
					referenceElement: aRightBottom
					relatedTo: aRightTop);
			clipChildren: false.

	anArrowThree := BlLineElement new
			border: (BlBorder paint: self defaultColor width: 1);
			fromAnchor: (BlNearestPositionBoundsAnchor
					referenceElement: aRightBottom
					relatedTo: aLeftBottom);
			toAnchor: (BlNearestPositionBoundsAnchor
					referenceElement: aLeftBottom
					relatedTo: aRightBottom);
			toHead: (BlArrowheadTriangle new
					background: self defaultColor;
					border: (BlBorder paint: self defaultColor width: 1));
			clipChildren: false.

	aLineThree := BlElement new.
	aLineThree
		size: self defaultWidth @ 6;
		background: Color lightGray;
		constraintsDo: [ :c | c linear horizontal alignCenter ].


	labelElement := GtSequenceDiagramUtility newMessageLabel
			constraintsDo: [ :c | 
				c ignoreByLayout.
				c ignored horizontal alignRightAt: 1.6.
				c ignored vertical alignCenter ].

	aContainer
		addChild: anArrowOne;
		addChild: anArrowTwo;
		addChild: anArrowThree;
		addChild: labelElement.

	self
		addChild: aLineOne;
		addChild: aContainer;
		addChild: aLineThree
]

{ #category : #'api - message view model' }
GtSequenceDiagramSelfMessageNodeElement >> onMessageViewModelChanged [
	self updateElement
]

{ #category : #'private - updating' }
GtSequenceDiagramSelfMessageNodeElement >> updateElement [
	labelElement text: self messageViewModel name asString
]
