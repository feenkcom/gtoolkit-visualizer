"
My subclasses implement treemap algorithms.
See my subclasses for more details and examples: {{gtClass:GtGraphTreemap|show=gtSubclassesFor:|expanded=true}}


"
Class {
	#name : #GtGraphTreemap,
	#superclass : #Object,
	#instVars : [
		'nodes'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #testing }
GtGraphTreemap class >> isAbstract [
	^ self name = #GtGraphTreemap 
]

{ #category : #factory }
GtGraphTreemap class >> sliceHorizontal [
	^ GtGraphTreemapSlice horizontal
]

{ #category : #factory }
GtGraphTreemap class >> sliceVertical [
	^ GtGraphTreemapSlice vertical
]

{ #category : #factory }
GtGraphTreemap class >> squarify [
	^ GtGraphTreemapSquarify new
]

{ #category : #adding }
GtGraphTreemap >> addNode: aNode [
	self updateNode: aNode.
	self nodes: (self nodes copyWith: aNode)
]

{ #category : #converting }
GtGraphTreemap >> asElement [
	<return: #BlElement>
	| aContainer |
	aContainer := BlElement new
		size: self extent;
		background: Color white;
		border: (BlBorder paint: Color lightGray width: 1).
	self nodes do: [ :eachNode | 
		aContainer addChild: (eachNode asElement
			background: Color random;
			size: eachNode extent asFloatPoint;
			relocate: eachNode position asFloatPoint) ].
	^ aContainer
]

{ #category : #converting }
GtGraphTreemap >> asElementWithInformation [
	<return: #BlElement>
	| aContainer |
	aContainer := BlElement new
		layout: (BlLinearLayout vertical cellSpacing: 3);
		background: Color white;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ].
	aContainer addChild: (self asElement
		constraintsDo: [ :c |
			c linear horizontal alignCenter]).
	aContainer addChild: (BlTextElement new
		text: (('Extent: ', self extent rounded asString) asRopedText glamorousCodeFontAndSize);
		constraintsDo: [ :c |
			c linear horizontal alignCenter ]).
	^ aContainer
]

{ #category : #accessing }
GtGraphTreemap >> extent [
	<return: #Point>
	^ self subclassResponsibility
]

{ #category : #'gt-extension' }
GtGraphTreemap >> gtNodesFor: aView [
	<gtView>
	self nodes ifNil: [ ^ aView empty ].
	^ (self nodes gtItemsFor: aView)
		title: 'Nodes';
		priority: 5
]

{ #category : #'gt-extension' }
GtGraphTreemap >> gtPreviewFor: aView [
	<gtView>
	self nodes ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Preview';
		priority: 1;
		stencil: [ self asElementWithInformation asScalableElement
			margin: (BlInsets all: 10) ]
]

{ #category : #accessing }
GtGraphTreemap >> height [
	^ self extent y
]

{ #category : #initialization }
GtGraphTreemap >> initialize [
	super initialize.
	self initializeNodes.
]

{ #category : #initialization }
GtGraphTreemap >> initializeNodes [
	nodes := #()
]

{ #category : #enumerating }
GtGraphTreemap >> nodeValues [
	<return: #Array of: #Number>
	^ Array streamContents: [ :aStream |
		self nodesDo: [ :eachNode | aStream nextPut: eachNode value ] ]
]

{ #category : #accessing }
GtGraphTreemap >> nodes [
	<return: #Array>
	^ nodes
]

{ #category : #accessing }
GtGraphTreemap >> nodes: anObject [
	nodes := anObject
]

{ #category : #enumerating }
GtGraphTreemap >> nodesDo: aBlock [
	self nodes do: aBlock
]

{ #category : #'seas optimizations' }
GtGraphTreemap >> updateNode: aNode [
	self subclassResponsibility
]

{ #category : #accessing }
GtGraphTreemap >> width [
	^ self extent x
]
