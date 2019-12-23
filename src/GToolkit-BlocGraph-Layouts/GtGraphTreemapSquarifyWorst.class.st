Class {
	#name : #GtGraphTreemapSquarifyWorst,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'length',
		'breadth'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #adding }
GtGraphTreemapSquarifyWorst >> addNode: aNode [ 
	self nodes addNode: aNode
]

{ #category : #converting }
GtGraphTreemapSquarifyWorst >> asElement [
	^ GtGraphUtilities default 
		rectangleOn: self 
		extent: self extent 
		margin: (BlInsets all: 0)
]

{ #category : #converting }
GtGraphTreemapSquarifyWorst >> asElementWithInformation [
	^ GtGraphUtilities default 
		informationForRectangle: self asElement 
		bounds: self bounds
]

{ #category : #converting }
GtGraphTreemapSquarifyWorst >> asElementWithNodes [
	| aContainer aNextNodePosition |
	aContainer := BlElement new.
	aContainer layout: BlFitLayout new.
	aContainer constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	aContainer addChild: self asElementWithInformation.
	aNextNodePosition := 0@0.
	self nodes do: [ :eachNode | 
		| anExtent anElement |
		anExtent := self nodeExtent: eachNode.
		anElement := GtGraphUtilities default 
			rectangleOn: eachNode 
			extent: anExtent 
			margin: (BlInsets all: 0).
		GtGraphUtilities default 
			informationForRectangle: anElement 
			bounds: (aNextNodePosition extent: anExtent).
		anElement
			background: (Color random alpha: 0.5);
			size: anExtent asFloatPoint;
			relocate: aNextNodePosition asFloatPoint.
		aContainer addChild: anElement.
		aNextNodePosition := aNextNodePosition + (0 @ anExtent y) ].
	^ aContainer
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorst >> bounds [
	^ 0@0 extent: self extent
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorst >> breadth [
	^ breadth
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorst >> breadth: anObject [
	breadth := anObject
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorst >> extent [
	<return: #Point>
	^ self breadth @ self length
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyWorst >> gtNodesFor: aView [
	<gtView>
	self nodes ifNil: [ ^ aView empty ].
	^ aView columnedList 
		title: 'Nodes';
		items: [ self nodes ];
		column: 'Weight' 
			item: [ :aNode | aNode weight ] 
			format: [ :aNumber | self printNumber: aNumber ];
		column: 'Worst Value' 
			item: [ :aNode | self worstValueForNode: aNode ] 
			format: [ :aNumber | self printNumber: aNumber ];
		column: 'Extent'
			item: [ :aNode | self nodeExtent: aNode ]
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyWorst >> gtPreviewFor: aView [
	<gtView>
	self length ifNil: [ ^ aView empty ].
	self breadth ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Preview';
		priority: 1;
		stencil: [ self asElementWithNodes asScalableElement
			margin: (BlInsets all: 10) ]
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyWorst >> gtWorstValueFor: aView [
	<gtView>
	self nodes ifNil: [ ^ aView empty ].
	self nodes ifEmpty: [ ^ aView empty ].
	^ (self value gtPreviewFor: aView)
		title: 'Value'
]

{ #category : #initialization }
GtGraphTreemapSquarifyWorst >> initialize [
	super initialize.
	nodes := GtGraphTreemapSquarifyNodes new.
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorst >> length [
	^ length
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorst >> length: anObject [
	length := anObject
]

{ #category : #'computing area' }
GtGraphTreemapSquarifyWorst >> maxWeightArea [
	<return: #Number>
	^ self maxWeightNode weight * self totalArea.
]

{ #category : #'computing area' }
GtGraphTreemapSquarifyWorst >> maxWeightNode [
	<return: #GtGraphTreemapNode>
	^ self nodes detectMax: [ :eachNode | eachNode weight ].
]

{ #category : #'computing area' }
GtGraphTreemapSquarifyWorst >> minWeightNode [
	<return: #GtGraphTreemapNode>
	^ self nodes detectMin: [ :eachNode | eachNode weight ].
]

{ #category : #'computing area' }
GtGraphTreemapSquarifyWorst >> nodeArea: aNode [
	^ aNode weight * self totalArea
]

{ #category : #'computing area' }
GtGraphTreemapSquarifyWorst >> nodeExtent: aNode [
	^ self nodesBreadth @ (self nodeLength: aNode)
]

{ #category : #'computing area' }
GtGraphTreemapSquarifyWorst >> nodeLength: aNode [
	^ (self nodeArea: aNode) / self nodesBreadth
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorst >> nodes [
	<return: #GtGraphTreemapSquarifyNodes>
	^ nodes
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorst >> nodes: aGtGraphTreemapSquarifyNodes [
	nodes := aGtGraphTreemapSquarifyNodes
]

{ #category : #'computing area' }
GtGraphTreemapSquarifyWorst >> nodesArea [
	^ self totalWeight * self totalArea
]

{ #category : #'computing area' }
GtGraphTreemapSquarifyWorst >> nodesBreadth [
	^ self nodesArea / self length
]

{ #category : #'computing area' }
GtGraphTreemapSquarifyWorst >> nodesCount [
	<return: #Integer>
	^ self nodes size
]

{ #category : #printing }
GtGraphTreemapSquarifyWorst >> printNumber: aNumber [
	<return: #String>
	aNumber isFloat ifTrue: [ ^ aNumber printString ].
	^ aNumber printString, ' = ', (aNumber asFloat round: 4) printString
]

{ #category : #'computing area' }
GtGraphTreemapSquarifyWorst >> totalArea [
	<return: #Number>
	^ self length * self breadth
]

{ #category : #'computing area' }
GtGraphTreemapSquarifyWorst >> totalWeight [
	"Return sum of all node weights"
	<return: #Number>
	^ self nodes 
		ifNotEmpty: [ :theNodes | theNodes sum: #weight ]
		ifEmpty: [ 0 ]
]

{ #category : #evaluating }
GtGraphTreemapSquarifyWorst >> value [
	"Return worst aspect ratio value"
	<return: #Number>
	^ self subclassResponsibility
]

{ #category : #'computing area' }
GtGraphTreemapSquarifyWorst >> worstValueForNode: aNode [
	"Worst value for a node"
	^ self subclassResponsibility
]
