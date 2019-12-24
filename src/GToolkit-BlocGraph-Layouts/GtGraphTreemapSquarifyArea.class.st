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

{ #category : #accessing }
GtGraphTreemapSquarifyArea >> extent [
	^ rectangle extent
]

{ #category : #accessing }
GtGraphTreemapSquarifyArea >> extent: aPoint [ 
	self rectangle: (GtGraphTreemapSquarifyAreaRectangle position: 0@0 extent: aPoint).
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

{ #category : #layout }
GtGraphTreemapSquarifyArea >> layoutNodes [
	self rectangle layoutRow: self
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
		self layoutNodes.
		^ self ].
	aNewArea := self copyWithNode: aNode.
	self worst >= aNewArea worst
		ifTrue: [
			"the aspect ratio is improved"
			self addNode: aNode.
			self layoutNodes ]
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

{ #category : #accessing }
GtGraphTreemapSquarifyArea >> worst [
	"gives the highest aspect ratio"
	<return: #Number>
	^ worst value
]
