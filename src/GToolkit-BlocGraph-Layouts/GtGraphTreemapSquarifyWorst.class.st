Class {
	#name : #GtGraphTreemapSquarifyWorst,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'totalArea',
		'length'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #adding }
GtGraphTreemapSquarifyWorst >> addNode: aNode [ 
	self nodes: (self nodes copyWith: aNode)
]

{ #category : #'accessing - occupied area' }
GtGraphTreemapSquarifyWorst >> area [
	^ self weight * self totalArea
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

{ #category : #converting }
GtGraphTreemapSquarifyWorst >> asReversedElement [
	^ GtGraphUtilities default 
		rectangleOn: self 
		extent: self reversedExtent 
		margin: (BlInsets all: 0)
]

{ #category : #converting }
GtGraphTreemapSquarifyWorst >> asReversedElementWithInformation [
	^ GtGraphUtilities default 
		informationForRectangle: self asReversedElement 
		bounds: self reversedBounds
]

{ #category : #converting }
GtGraphTreemapSquarifyWorst >> asReversedElementWithNodes [
	| aContainer aNextNodePosition |
	aContainer := BlElement new.
	aContainer layout: BlFitLayout new.
	aContainer constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	aContainer addChild: self asReversedElementWithInformation.
	aNextNodePosition := 0@0.
	self nodes do: [ :eachNode | 
		| anExtent anElement |
		anExtent := self nodeReversedExtent: eachNode.
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
		aNextNodePosition := aNextNodePosition + (anExtent x @ 0) ].
	^ aContainer
]

{ #category : #'accessing - occupied area' }
GtGraphTreemapSquarifyWorst >> bounds [
	^ 0@0 extent: self extent
]

{ #category : #'accessing - occupied area' }
GtGraphTreemapSquarifyWorst >> breadth [
	^ self area / self length
]

{ #category : #'accessing - occupied area' }
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
		column: 'Vertical Extent'
			item: [ :aNode | | anExtent | 
				anExtent := (self nodeExtent: aNode) asFloatPoint.
				anExtent x rounded @ anExtent y rounded ];
		column: 'Horizontal Extent'
			item: [ :aNode | | anExtent | 
				anExtent := (self nodeReversedExtent: aNode) asFloatPoint.
				anExtent x rounded @ anExtent y rounded ]
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyWorst >> gtPreviewFor: aView [
	<gtView>
	self length ifNil: [ ^ aView empty ].
	self breadth ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Vertical Preview';
		priority: 1;
		stencil: [ self asElementWithNodes asScalableElement
			margin: (BlInsets all: 10) ]
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyWorst >> gtReversedPreviewFor: aView [
	<gtView>
	self length ifNil: [ ^ aView empty ].
	self breadth ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Horizontal Preview';
		priority: 2;
		stencil: [ self asReversedElementWithNodes asScalableElement
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
	nodes := #()
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorst >> length [
	^ length
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorst >> length: anObject [
	length := anObject
]

{ #category : #'accessing - nodes' }
GtGraphTreemapSquarifyWorst >> maxWeightNode [
	<return: #GtGraphTreemapNode>
	^ self nodes detectMax: [ :eachNode | eachNode weight ].
]

{ #category : #'accessing - nodes' }
GtGraphTreemapSquarifyWorst >> minWeightNode [
	<return: #GtGraphTreemapNode>
	^ self nodes detectMin: [ :eachNode | eachNode weight ].
]

{ #category : #'accessing - nodes' }
GtGraphTreemapSquarifyWorst >> nodeArea: aNode [
	^ aNode weight * self totalArea
]

{ #category : #'accessing - nodes' }
GtGraphTreemapSquarifyWorst >> nodeExtent: aNode [
	^ self nodesBreadth @ (self nodeLength: aNode)
]

{ #category : #'accessing - nodes' }
GtGraphTreemapSquarifyWorst >> nodeLength: aNode [
	^ (self nodeArea: aNode) / self nodesBreadth
]

{ #category : #'accessing - nodes' }
GtGraphTreemapSquarifyWorst >> nodeReversedExtent: aNode [
	^ (self nodeLength: aNode) @ self nodesBreadth
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorst >> nodes [
	<return: #Array of: #GtGraphTreemapNode>
	^ nodes
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorst >> nodes: anArray [
	nodes := anArray
]

{ #category : #'accessing - nodes' }
GtGraphTreemapSquarifyWorst >> nodesBreadth [
	^ self area / self length
]

{ #category : #'accessing - nodes' }
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

{ #category : #'accessing - occupied area' }
GtGraphTreemapSquarifyWorst >> reversedBounds [
	^ 0@0 extent: self reversedExtent
]

{ #category : #'accessing - occupied area' }
GtGraphTreemapSquarifyWorst >> reversedExtent [
	<return: #Point>
	^ self length @ self breadth
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorst >> totalArea [
	<return: #Number>
	^ totalArea
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorst >> totalArea: anObject [
	totalArea := anObject
]

{ #category : #evaluating }
GtGraphTreemapSquarifyWorst >> value [
	"Return worst aspect ratio value"
	<return: #Number>
	^ self subclassResponsibility
]

{ #category : #'accessing - occupied area' }
GtGraphTreemapSquarifyWorst >> weight [
	"Return sum of all node weights"
	<return: #Number>
	^ self nodes 
		ifNotEmpty: [ :theNodes | theNodes sum: #weight ]
		ifEmpty: [ 0 ]
]

{ #category : #'accessing - nodes' }
GtGraphTreemapSquarifyWorst >> worstValueForNode: aNode [
	"Worst value for a node"
	^ self subclassResponsibility
]
