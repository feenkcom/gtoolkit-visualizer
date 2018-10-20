Class {
	#name : #GtMondrianUMLClassElement,
	#superclass : #GtWidthExpandingElement,
	#instVars : [
		'label',
		'labelContainer',
		'contents',
		'grid'
	],
	#category : 'GToolkit-Mondrian'
}

{ #category : #'as yet unclassified' }
GtMondrianUMLClassElement class >> withContainers: aCollectionOfSymbols [
	^ self new newContainers: aCollectionOfSymbols
]

{ #category : #'as yet unclassified' }
GtMondrianUMLClassElement class >> withDefaultContainer [
	^ self withContainers: #(#default)
]

{ #category : #initialization }
GtMondrianUMLClassElement >> initialize [
	super initialize.
	label := BlTextElement new
		text: '' asRopedText;
		padding: (BlInsets all: 5);
		constraintsDo: [ :c | c frame horizontal alignCenter ];
		preventMouseEvents.
	labelContainer := BlElement new.
	labelContainer 
		layout: BlFrameLayout new;
		background: Color transparent;
		border: (BlBorder paint: Color gray);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		addChild: label;
		preventMouseEvents.
    self
		layout: (BlGridLayout vertical cellSpacing: -1);
		padding: (BlInsets all: 1);
		constraintsDo: [ :c |
			c vertical fitContent.
			c horizontal fitContent ];
		background: Color transparent;
		addChildren: { labelContainer }
]

{ #category : #accessing }
GtMondrianUMLClassElement >> label: aString [
	label text: aString asRopedText
]

{ #category : #accessing }
GtMondrianUMLClassElement >> labelAttributes: aCollection [
	label text attributes: aCollection
]

{ #category : #accessing }
GtMondrianUMLClassElement >> newContainers: aCollectionOfSymbols [
	aCollectionOfSymbols do: [ :each | 
		| element |
		element := BlElement new
			layout: BlLinearLayout horizontal;
			constraintsDo: [ :c | 
				c vertical fitContent.
				c horizontal fitContent ];
			background: Color transparent;
			border: (BlBorder paint: Color gray);
			padding: (BlInsets all: 5).
		element graph beChildrenContainer: each.
		self addChild: element ]
]
