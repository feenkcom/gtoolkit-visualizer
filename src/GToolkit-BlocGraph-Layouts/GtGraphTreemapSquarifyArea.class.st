Class {
	#name : #GtGraphTreemapSquarifyArea,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'rectangle',
		'nextArea'
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
	rectangle := GtGraphTreemapSquarifyAreaRectangle position: 0@0 extent: aPoint
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyArea >> gtAllAreasFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Rows';
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
	^ self rectangle gtPreviewFor: aView
]

{ #category : #initialization }
GtGraphTreemapSquarifyArea >> initialize [
	super initialize.
	nodes := #().
	rectangle := GtGraphTreemapSquarifyAreaRectangle null.
]

{ #category : #accessing }
GtGraphTreemapSquarifyArea >> nodes [
	^ nodes
]

{ #category : #accessing }
GtGraphTreemapSquarifyArea >> nodes: anObject [
	nodes := anObject
]

{ #category : #accessing }
GtGraphTreemapSquarifyArea >> nodes: aCollectionOfNodes with: aNode [
	self nodes: (aCollectionOfNodes copyWith: aNode)
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
GtGraphTreemapSquarifyArea >> rectangle: anObject [
	rectangle := anObject
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
	| aNewRow |
	self nodes ifEmpty: [ 
		self addNode: aNode.
		self rectangle layoutRow: self.
		^ self ].
	aNewRow := self copyWithNode: aNode.
	(self worst >= aNewRow worst)
		ifTrue: [
			"the spaect ratio is improved"
			self addNode: aNode.
			self rectangle layoutRow: self ]
		ifFalse: [ 
			nextArea := GtGraphTreemapSquarifyArea new.
			nextArea rectangle: self rectangle remainingRectangle.
			nextArea squarifyHereNode: aNode. ]
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
	| anOccupiedWeight anOccupiedExtent aMinRatio aMaxRatio aMax aMin |
	anOccupiedWeight := self occupiedWeight.
	anOccupiedExtent := self rectangle extentOccupiedBy: self.
	aMaxRatio := self nodes detectMax: [ :eachNode | eachNode weight ].
	aMinRatio := self nodes detectMin: [ :eachNode | eachNode weight ].
	aMax := self rectangle aspectRatioForWeightRatio: (aMaxRatio weight / anOccupiedWeight) occupiedExtent: anOccupiedExtent.
	aMin := self rectangle aspectRatioForWeightRatio: (aMinRatio weight / anOccupiedWeight) occupiedExtent: anOccupiedExtent.
	^ aMax max: aMin
]
