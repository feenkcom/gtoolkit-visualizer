"
I represent an area in which ${class:GtGraphTreemapNode}$ nodes are alocated along with shorter rectangle size.
I use ${class:GtGraphTreemapSquarifyAreaRectangle}$ to layout nodes.
My main algorithm that split an orignal area into sub-areas is implemented in the ${method:GtGraphTreemapSquarifyArea>>#squarifyHereNode:}$ method.
I use ${class:GtGraphTreemapSquarifyWorst}$ in order to decide whether a new node should be added to my area or rather a new area should be created.

!! Example 

In the following example, you can see one are with two nodes: 
${example:GtGraphTreemapLayoutExamples>>#areaWithTwoNodes|codeExpanded=false|previewExpanded=true}$

If we add another node, all area nodes get less squared:
${example:GtGraphTreemapLayoutExamples>>#areaWithThreeNodes|codeExpanded=false|previewExpanded=true}$

The algorithm therefore decides to rather create a new area with the third node and keeps the first two nodes in the existing area. A new node is added only if the worst aspect ratio (among all area nodes) is improved. Otherwise, the new node is added to a new area.

"
Class {
	#name : #GtGraphTreemapSquarifyArea,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'rectangle',
		'nextArea',
		'worst'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #testing }
GtGraphTreemapSquarifyArea class >> isDeprecated [
	^ true
]

{ #category : #accessing }
GtGraphTreemapSquarifyArea >> addNode: aNode [ 
	self nodes: (self nodes copyWith: aNode)
]

{ #category : #enumerating }
GtGraphTreemapSquarifyArea >> allAreas [
	<return: #Array of: #GtGraphTreemapSquarifyArea>
	^ Array streamContents: [ :aStream | 
		self areasDo: [ :eachRow | aStream nextPut: eachRow ] ]
]

{ #category : #enumerating }
GtGraphTreemapSquarifyArea >> areasDo: anOneArgBlock [
	anOneArgBlock cull: self.
	nextArea ifNotNil: [ :theNextRow | theNextRow areasDo: anOneArgBlock ]
]

{ #category : #converting }
GtGraphTreemapSquarifyArea >> asElementWithOccupiedArea [
	| aContainer |
	aContainer := BlElement new.
	aContainer layout: BlFitLayout new.
	aContainer constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	aContainer addChild: self rectangle asElementWithOccupiedArea.
	self nodesDo: [ :eachNode | 
		eachNode hasBounds ifTrue: [ 
			| anElement |
			anElement := eachNode asElement
				size: eachNode extent asFloatPoint;
				relocate: eachNode position asFloatPoint.
			anElement allChildrenBreadthFirstDo: [ :eachChild | 
				eachChild background: BlBackground transparent ]. 
			aContainer addChild: anElement ] ].
	^ aContainer
]

{ #category : #copying }
GtGraphTreemapSquarifyArea >> copyWithNode: aNode [ 
	^ self class new 
		nodes: self nodes with: aNode;
		rectangle: self rectangle
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyArea >> gtAllAreasFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Areas';
		priority: 3;
		items: [ self allAreas ];
		column: 'Type' item: [ :aRow | aRow orientationName ] width: 100;
		column: 'Bounds' item: [ :aRow | aRow rectangleBounds ];
		column: 'Remaining Bounds' item: [ :aRow | aRow rectangleRemainingBounds ];
		column: 'Number of Nodes' item: [ :aRow | aRow nodesCount ].
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyArea >> gtNodesFor: aView [
	<gtView>
	self nodes ifNil: [ ^ aView empty ].
	^ (self nodes gtItemsFor: aView)
		title: 'Nodes';
		priority: 2
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyArea >> gtPreviewFor: aView [
	<gtView>
	self rectangle ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Preview';
		priority: 1;
		stencil: [ self asElementWithOccupiedArea asScalableElement
			margin: (BlInsets all: 10) ]
]

{ #category : #initialization }
GtGraphTreemapSquarifyArea >> initialize [
	super initialize.
	nodes := #().
	rectangle := GtGraphTreemapSquarifyAreaRectangle null.
	worst := GtGraphTreemapSquarifyWorstAspectRatio new.
]

{ #category : #accessing }
GtGraphTreemapSquarifyArea >> nodes [
	^ nodes
]

{ #category : #accessing }
GtGraphTreemapSquarifyArea >> nodes: aGtGraphTreemapSquarifyNodes [
	nodes := aGtGraphTreemapSquarifyNodes.
	worst nodes: aGtGraphTreemapSquarifyNodes.
]

{ #category : #accessing }
GtGraphTreemapSquarifyArea >> nodes: anArray with: aNode [
	self nodes: (anArray copyWith: aNode)
]

{ #category : #accessing }
GtGraphTreemapSquarifyArea >> nodesCount [
	^ self nodes size
]

{ #category : #enumerating }
GtGraphTreemapSquarifyArea >> nodesDo: anOneArgBlock [
	self nodes do: anOneArgBlock
]

{ #category : #accessing }
GtGraphTreemapSquarifyArea >> occupiedWeight [
	^ self nodes 
		ifNotEmpty: [ :theNodes | theNodes sum: #weight ]
		ifEmpty: [ 0 ]
]

{ #category : #accessing }
GtGraphTreemapSquarifyArea >> orientationName [
	^ self rectangle name
]

{ #category : #printing }
GtGraphTreemapSquarifyArea >> printOn: aStream [
	aStream 
		nextPutAll: 'Area: ';
		print: (self rectangle ifNil: [ 'uninitialized' ]).
]

{ #category : #accessing }
GtGraphTreemapSquarifyArea >> rectangle [
	^ rectangle
]

{ #category : #accessing }
GtGraphTreemapSquarifyArea >> rectangle: aGtGraphTreemapSquarifyAreaRectangle [
	rectangle := aGtGraphTreemapSquarifyAreaRectangle.
	worst totalArea: rectangle original height * rectangle original width.
	worst length: rectangle length.
]

{ #category : #accessing }
GtGraphTreemapSquarifyArea >> rectangleBounds [
	^ self rectangle bounds
]

{ #category : #accessing }
GtGraphTreemapSquarifyArea >> rectangleRemainingBounds [
	^ self rectangle remainingBounds
]

{ #category : #squarifying }
GtGraphTreemapSquarifyArea >> squarifyHereNode: aNode [ 
	| aNewArea |
	self nodes ifEmpty: [ 
		self addNode: aNode.
		self squarifyNodes.
		^ self ].
	aNewArea := self copyWithNode: aNode.
	self worst >= aNewArea worst
		ifTrue: [
			"the aspect ratio is improved"
			self addNode: aNode.
			self squarifyNodes ]
		ifFalse: [ 
			"the aspect ratio is worst, let's create a new area"
			nextArea := GtGraphTreemapSquarifyArea new.
			nextArea rectangle: self rectangle remainingRectangle.
			nextArea squarifyHereNode: aNode. ].
]

{ #category : #squarifying }
GtGraphTreemapSquarifyArea >> squarifyNode: aNode [ 
	nextArea ifNotNil: [ nextArea squarifyNode: aNode. ^ self ].
	self squarifyHereNode: aNode.
]

{ #category : #layout }
GtGraphTreemapSquarifyArea >> squarifyNodes [
	self rectangle squarifyStep: self
]

{ #category : #accessing }
GtGraphTreemapSquarifyArea >> worst [
	"gives the highest aspect ratio"
	<return: #Number>
	^ worst value
]
