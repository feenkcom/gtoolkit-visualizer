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
		paint: GtSequenceDiagramUtility messageSendLineDefaultBackgroundColor;
		width: GtSequenceDiagramUtility messageLineWidth;
		build
]

{ #category : #initialization }
GtSequenceDiagramMessageEdgeElement >> defaultColor [
	^ GtSequenceDiagramUtility messageSendLineDefaultBackgroundColor
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
	self styleDefault.
]

{ #category : #initialization }
GtSequenceDiagramMessageEdgeElement >> initializeChildren [
	labelElement := GtSequenceDiagramUtility newMessageLabel
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
	labelElement aptitude
		foreground: GtSequenceDiagramUtility messageLabelDefaultForegroudColor.

	toHead ifNil: [ ^ self ].

	toHead background: self defaultColor.
	toHead border: self defaultBorder
]

{ #category : #'private - styling' }
GtSequenceDiagramMessageEdgeElement >> styleHovered [
	self hasInspecteableModel ifFalse: [ ^ self ].

	labelElement aptitude
		foreground: GtSequenceDiagramUtility hoveredBackgroundColor.

	toHead ifNil: [ ^ self ].
	toHead background: GtSequenceDiagramUtility hoveredBackgroundColor.
	toHead
		border: (BlBorder builder
				paint: GtSequenceDiagramUtility hoveredBackgroundColor;
				width: 2;
				build)
]

{ #category : #'private - updating' }
GtSequenceDiagramMessageEdgeElement >> updateElement [
	labelElement text: self messageViewModel name asString
]
