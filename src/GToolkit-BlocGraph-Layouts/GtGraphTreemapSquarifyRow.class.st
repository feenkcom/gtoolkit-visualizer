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
GtGraphTreemapSquarifyRow >> squarifyInTheLastRow: aNode [ 
	nextRow ifNotNil: [ nextRow squarifyInTheLastRow: aNode. ^ self ].
	self squarifyHereNode: aNode.
]

{ #category : #squarifying }
GtGraphTreemapSquarifyRow >> squarifyNode: aNode [ 
	self squarifyInTheLastRow: aNode.
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
	| anOccupiedWeight anOccupiedExtent aMaxLenght aMinLenght aMinRatio aMaxRatio aSum aWidth aMax aMin |
	anOccupiedWeight := self occupiedWeight.
	anOccupiedExtent := self rectangle extentOccupiedBy: self.
	aMaxRatio := self nodes detectMax: [ :eachNode | eachNode weight ].
	aMinRatio := self nodes detectMin: [ :eachNode | eachNode weight ].
	aMax := self rectangle aspectRatioForWeightRatio: (aMaxRatio weight / anOccupiedWeight) occupiedExtent: anOccupiedExtent.
	aMin := self rectangle aspectRatioForWeightRatio: (aMinRatio weight / anOccupiedWeight) occupiedExtent: anOccupiedExtent.
	^ aMax max: aMin
]

{ #category : #accessing }
GtGraphTreemapSquarifyRow >> worstAgain [
	"gives the highest aspect ratio"
	<return: #Number>
	| aMinRatio aMaxRatio aSum aWidth aMax aMin |
	aMaxRatio := self nodes detectMax: [ :eachNode | eachNode weight ].
	aMinRatio := self nodes detectMin: [ :eachNode | eachNode weight ].
	aSum := self rectangle original volume.
	aWidth := self rectangle length.
	aMax := aWidth squared * (aMaxRatio weight * aSum) / aSum squared.
	aMin := aSum squared / (aWidth squared * (aMinRatio weight * aSum)).
	^ aMax max: aMin
]

{ #category : #accessing }
GtGraphTreemapSquarifyRow >> worstAnother [
	"gives the highest aspect ratio"
	<return: #Number>
	| anOccupiedArea aMinArea aMaxArea aMinRatio aMaxRatio aLength |
	anOccupiedArea := self occupiedWeight * self rectangle volume.
	anOccupiedArea isZero ifTrue: [ ^ 0 ].
	aLength := self rectangle length.
	aMinArea := self minArea * self rectangle volume.
	aMaxArea := self maxArea * self rectangle volume.
	aMinRatio := aLength squared * aMinArea / anOccupiedArea squared.
	aMaxRatio := aLength squared * aMaxArea / anOccupiedArea squared.
	^ aMinRatio max: aMaxRatio
]

{ #category : #accessing }
GtGraphTreemapSquarifyRow >> worstAspectRatio [
	"gives the highest aspect ratio"
	<return: #Number>
	| aMinRatio aMaxRatio |
	aMinRatio := self nodes detectMin: [ :eachNode | eachNode weight ].
	aMaxRatio := self nodes detectMax: [ :eachNode | eachNode weight ].
	^ (aMinRatio aspectRatio) max: (aMaxRatio aspectRatio)
]

{ #category : #accessing }
GtGraphTreemapSquarifyRow >> worstOld [
	"gives the highest aspect ratio"
	<return: #Number>
	| anOccupiedArea aMinArea aMaxArea aMinRatio aMaxRatio aRemaingSpace |
	anOccupiedArea := self occupiedWeight.
	anOccupiedArea isZero ifTrue: [ ^ 0 ].
	aRemaingSpace := 1 - anOccupiedArea.
	aMinArea := self minArea.
	aMaxArea := self maxArea.
	aMinRatio := aRemaingSpace squared * aMinArea / anOccupiedArea squared.
	aMaxRatio := aRemaingSpace squared * aMaxArea / anOccupiedArea squared.
	^ aMinRatio max: aMaxRatio
]

{ #category : #accessing }
GtGraphTreemapSquarifyRow >> worstVolume [
	"gives the highest aspect ratio"
	<return: #Number>
	| anOccupiedArea aMinArea aMaxArea aMinRatio aMaxRatio aRemaingSpace |
	anOccupiedArea := self occupiedWeight.
	anOccupiedArea isZero ifTrue: [ ^ 0 ].
	aRemaingSpace := self rectangle volume - anOccupiedArea.
	aMinArea := self minArea * self rectangle volume.
	aMaxArea := self maxArea * self rectangle volume.
	aMinRatio := aRemaingSpace squared * aMinArea / anOccupiedArea squared.
	aMaxRatio := aRemaingSpace squared * aMaxArea / anOccupiedArea squared.
	^ aMinRatio max: aMaxRatio
]
