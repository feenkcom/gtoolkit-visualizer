Class {
	#name : #GtGraphTreemapSquarifyRow,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'rectangle',
		'nextRow'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #accessing }
GtGraphTreemapSquarifyRow >> addNode: aNode [ 
	self nodes: (self nodes copyWith: aNode)
]

{ #category : #enumerating }
GtGraphTreemapSquarifyRow >> allRows [
	<return: #Array of: #GtGraphTreemapSquarifyRow>
	^ Array streamContents: [ :aStream | 
		self streamRowsTo: aStream ]
]

{ #category : #copying }
GtGraphTreemapSquarifyRow >> copyWithNode: aNode [ 
	^ self class new 
		nodes: self nodes with: aNode;
		rectangle: self rectangle
]

{ #category : #accessing }
GtGraphTreemapSquarifyRow >> extent [
	^ rectangle extent
]

{ #category : #accessing }
GtGraphTreemapSquarifyRow >> extent: aPoint [ 
	rectangle := GtGraphTreemapSquarifyRectangle position: 0@0 extent: aPoint
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyRow >> gtAllRowsFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Rows';
		items: [ self allRows ];
		column: 'Type' item: [ :aRow | aRow orientationName ] width: 100;
		column: 'Bounds' item: [ :aRow | aRow rectangleBounds ];
		column: 'Remaining Bounds' item: [ :aRow | aRow rectangleRemainingBounds ];
		column: 'Number of Nodes' item: [ :aRow | aRow nodesCount ].
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyRow >> gtNodesFor: aView [
	<gtView>
	self nodes ifNil: [ ^ aView empty ].
	^ (self nodes gtItemsFor: aView)
		title: 'Nodes'
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyRow >> gtPreviewFor: aView [
	<gtView>
	self rectangle ifNil: [ ^ aView empty ].
	^ self rectangle gtPreviewFor: aView
]

{ #category : #initialization }
GtGraphTreemapSquarifyRow >> initialize [
	super initialize.
	nodes := #().
	rectangle := GtGraphTreemapSquarifyRectangle null.
]

{ #category : #accessing }
GtGraphTreemapSquarifyRow >> maxArea [
	^ self nodes 
		ifNotEmpty: [ :theNodes | (theNodes detectMax: #weight) weight ]
		ifEmpty: [ 0 ]
]

{ #category : #accessing }
GtGraphTreemapSquarifyRow >> minArea [
	^ self nodes 
		ifNotEmpty: [ :theNodes | (theNodes detectMin: #weight) weight ]
		ifEmpty: [ 0 ]
]

{ #category : #accessing }
GtGraphTreemapSquarifyRow >> nodes [
	^ nodes
]

{ #category : #accessing }
GtGraphTreemapSquarifyRow >> nodes: anObject [
	nodes := anObject
]

{ #category : #accessing }
GtGraphTreemapSquarifyRow >> nodes: aCollectionOfNodes with: aNode [
	self nodes: (aCollectionOfNodes copyWith: aNode)
]

{ #category : #accessing }
GtGraphTreemapSquarifyRow >> nodesCount [
	^ self nodes size
]

{ #category : #accessing }
GtGraphTreemapSquarifyRow >> occupiedWeight [
	^ self nodes 
		ifNotEmpty: [ :theNodes | theNodes sum: #weight ]
		ifEmpty: [ 0 ]
]

{ #category : #accessing }
GtGraphTreemapSquarifyRow >> orientationName [
	^ self rectangle name
]

{ #category : #accessing }
GtGraphTreemapSquarifyRow >> rectangle [
	^ rectangle
]

{ #category : #accessing }
GtGraphTreemapSquarifyRow >> rectangle: anObject [
	rectangle := anObject
]

{ #category : #accessing }
GtGraphTreemapSquarifyRow >> rectangleBounds [
	^ self rectangle bounds
]

{ #category : #accessing }
GtGraphTreemapSquarifyRow >> rectangleRemainingBounds [
	^ self rectangle remainingBounds
]

{ #category : #squarifying }
GtGraphTreemapSquarifyRow >> squarifyHereNode: aNode [ 
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
			nextRow := GtGraphTreemapSquarifyRow new.
			nextRow rectangle: self rectangle remainingRectangle.
			nextRow squarifyHereNode: aNode. ]
]

{ #category : #squarifying }
GtGraphTreemapSquarifyRow >> squarifyNode: aNode [ 
	nextRow ifNotNil: [ nextRow squarifyNode: aNode. ^ self ].
	self squarifyHereNode: aNode.
]

{ #category : #enumerating }
GtGraphTreemapSquarifyRow >> streamRowsTo: aStream [
	aStream nextPut: self.
	nextRow ifNotNil: [ nextRow streamRowsTo: aStream ]
]

{ #category : #accessing }
GtGraphTreemapSquarifyRow >> worst [
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
