"
I am a  builder for specifying nodes. I exist mainly for the convenience of having a fluent API.

I work in close collaboration with the `GtMondrianStep` who eventually has to store the nodes I produce.


"
Class {
	#name : #GtMondrianNodeBuilder,
	#superclass : #GtMondrianGraphBuilder,
	#instVars : [
		'createdElements'
	],
	#category : #'GToolkit-Mondrian'
}

{ #category : #private }
GtMondrianNodeBuilder >> defaultNodeElement [
	^ BlElement new
		background: Color transparent;
		border: (BlBorder paint: Color black width: 2);
		padding: (BlInsets all: 5);
		size: 5@5;
		zIndex: 10
]

{ #category : #'scripting - shape' }
GtMondrianNodeBuilder >> ellipse: aBlock [
	self shape: [ :anObject :anElement |
		aBlock 
			cull: anObject 
			cull: (anElement geometry: BlEllipseGeometry new) ]
]

{ #category : #scripting }
GtMondrianNodeBuilder >> forEach: aBlock [
	self forEach: aBlock in: #default
]

{ #category : #scripting }
GtMondrianNodeBuilder >> forEach: aBlock in: aSymbol [
	createdElements
		do: [ :child | 
			self mondrian
				with:
					(GtMondrianStep new
						root: (child graph childrenContainerNamed: aSymbol))
				do: [ aBlock value: child graph model ] ].
	^ createdElements
]

{ #category : #initialize }
GtMondrianNodeBuilder >> initialize [
	createdElements := OrderedCollection new
]

{ #category : #accessing }
GtMondrianNodeBuilder >> labelled: aBlock [
	self stencil: [ :anObject | 
		| childrenContainer |
		childrenContainer := BrHorizontalPane new
			                     fitContent;
			                     alignCenter;
			                     padding: (BlInsets all: 5).
		childrenContainer graph beChildrenContainer: #default.
		BrVerticalPane new
			fitContent;
			alignCenter;
			addChild: (BrLabel new aptitude: BrGlamorousLabelAptitude; text: (aBlock cull: anObject));
			addChild: childrenContainer ]
]

{ #category : #scripting }
GtMondrianNodeBuilder >> nodeElementFor: anObject [
		| nodeElement |
	nodeElement := elementStencilBuilder 
		ifNotNil: [ elementStencilBuilder cull: anObject cull: self defaultNodeElement ]
		ifNil: [ self defaultNodeElement ].
	nodeElement graph model: anObject.
	nodeElement graph beNode.
	nodeElement addEventHandler: BlPullHandler new.

	^ nodeElement
]

{ #category : #'scripting - shape' }
GtMondrianNodeBuilder >> umlClassShapeWithName: aBlock [
	self
		stencil: [ :each | 
			GtMondrianUMLClassElement withDefaultContainer
				label: (aBlock value: each) asString ]
]

{ #category : #'scripting - shape' }
GtMondrianNodeBuilder >> umlClassShapeWithName: aBlock andTextAttributes: aTextAttributesBlock [
	self shape: [ :anObject |
		GtMondrianUMLClassElement withDefaultContainer 
			label: (aBlock value: anObject);
			labelAttributes: (aTextAttributesBlock value: anObject) ]
]

{ #category : #scripting }
GtMondrianNodeBuilder >> with: aCollection [
	| elements |
	elements := aCollection collect: [ :each |
		| child |
		child := self nodeElementFor: each.
		mondrian nodeAt: each put: child.
		child ].
	self topStep addChildren: elements asOrderedCollection.
	createdElements addAll: elements.
	^ elements
]

{ #category : #scripting }
GtMondrianNodeBuilder >> with: aCollection forEach: aBlock [
	self 
		with: aCollection;
		forEach: aBlock
]
