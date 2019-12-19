Class {
	#name : #GtGraphTreemapSquarifyRow,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'rectangle'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyRow >> copyWithNode: aNode [ 
	^ self class new nodes: self nodes with: aNode
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
GtGraphTreemapSquarifyRow >> gtNodesFor: aView [
	<gtView>
	self nodes ifNil: [ ^ aView empty ].
	^ (self nodes gtItemsFor: aView)
		title: 'Nodes'
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
GtGraphTreemapSquarifyRow >> occupiedArea [
	^ self nodes 
		ifNotEmpty: [ :theNodes | theNodes sum: #weight ]
		ifEmpty: [ 0 ]
]

{ #category : #accessing }
GtGraphTreemapSquarifyRow >> worst [
	"gives the highest aspect ratio"
	<return: #Number>
	| anOccupiedArea aMinArea aMaxArea aMinRatio aMaxRatio aRemaingSpace |
	anOccupiedArea := self occupiedArea.
	anOccupiedArea isZero ifTrue: [ ^ 0 ].
	aRemaingSpace := 1 - anOccupiedArea.
	aMinArea := self minArea.
	aMaxArea := self maxArea.
	aMinRatio := aRemaingSpace squared * aMinArea / anOccupiedArea squared.
	aMaxRatio := aRemaingSpace squared * aMaxArea / anOccupiedArea squared.
	^ aMinRatio max: aMaxRatio
]
