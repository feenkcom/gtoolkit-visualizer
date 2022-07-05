Class {
	#name : #GtSequenceDiagramMessageEdgeElement,
	#superclass : #BlLineElement,
	#traits : 'TGtWithSequenceDiagramMessageViewModel',
	#classTraits : 'TGtWithSequenceDiagramMessageViewModel classTrait',
	#instVars : [
		'styleCommonAptitude',
		'labelElement'
	],
	#category : #'GToolkit-SequenceDiagram-UI'
}

{ #category : #initialization }
GtSequenceDiagramMessageEdgeElement >> defaultBorder [
	^ BlBorder builder
		paint: Color black;
		width: 1;
		build
]

{ #category : #initialization }
GtSequenceDiagramMessageEdgeElement >> defaultColor [
	^ Color black
]

{ #category : #testing }
GtSequenceDiagramMessageEdgeElement >> hasInspecteableModel [
	^ self hasMessageViewModel and: [ self messageViewModel hasModel ]
]

{ #category : #initialization }
GtSequenceDiagramMessageEdgeElement >> initialize [
	super initialize.
	self initializeChildren.
	self initializeHead.
	self initializeStyle.
	self initializeEventHandlers.
]

{ #category : #initialization }
GtSequenceDiagramMessageEdgeElement >> initializeChildren [
	labelElement := BrLabel new
			fitContent;
			aptitude: (BrGlamorousLabelAptitude new
					glamorousCodeTinySize;
					background: Color white);
			text: '';
			zIndex: 3;
			constraintsDo: [ :c | 
				c ignoreByLayout.
				c ignored horizontal alignCenter.
				c ignored vertical alignCenter.
				c margin: (BlInsets top: -1) ].
	self addChild: labelElement
]

{ #category : #initialization }
GtSequenceDiagramMessageEdgeElement >> initializeEventHandlers [
	self when: BlClickEvent do: [ :anEvent | self onMouseClick: anEvent ]
]

{ #category : #initialization }
GtSequenceDiagramMessageEdgeElement >> initializeHead [
]

{ #category : #initialization }
GtSequenceDiagramMessageEdgeElement >> initializeStyle [
	self
		aptitude: (BrStyleCommonAptitude new
				default: [ :aStyle | aStyle border: self defaultBorder ];
				hovered: [ :aStyle | aStyle do: [ self styleHovered ] after: [ self styleDefault ] ])
]

{ #category : #'api - message view model' }
GtSequenceDiagramMessageEdgeElement >> onMessageViewModelChanged [
	self updateElement
]

{ #category : #'private - event handling' }
GtSequenceDiagramMessageEdgeElement >> onMouseClick: anEvent [
	self hasInspecteableModel ifFalse: [ ^ self ].

	self phlow spawnObject: self messageViewModel model
]

{ #category : #'private - styling' }
GtSequenceDiagramMessageEdgeElement >> styleDefault [
	self border: self defaultBorder.
	labelElement aptitude foreground: BrGlamorousColors defaultButtonTextColor.

	toHead ifNil: [ ^ self ].

	toHead background: self defaultColor.
	toHead border: self defaultBorder
]

{ #category : #'private - styling' }
GtSequenceDiagramMessageEdgeElement >> styleHovered [
	self hasInspecteableModel ifFalse: [ ^ self ].

	labelElement aptitude foreground: BrGlamorousColors hoveredButtonTextColor.

	toHead ifNil: [ ^ self ].
	toHead background: BrGlamorousColors hoveredButtonBorderColor.
	toHead
		border: (BlBorder builder
				paint: BrGlamorousColors hoveredButtonBorderColor;
				width: 2;
				build)
]

{ #category : #'private - updating' }
GtSequenceDiagramMessageEdgeElement >> updateElement [
	labelElement text: self messageViewModel name asString
]
