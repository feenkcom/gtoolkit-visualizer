Class {
	#name : #GtGraphTreemapSquarify,
	#superclass : #GtGraphTreemap,
	#instVars : [
		'row',
		'extent'
	],
	#classVars : [
		'Phi'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #'class initialization' }
GtGraphTreemapSquarify class >> initialize [
	self initializePhi.
]

{ #category : #'class initialization' }
GtGraphTreemapSquarify class >> initializePhi [
	Phi ifNil: [ Phi := (1 + 5 sqrt) / 2 ]
]

{ #category : #accessing }
GtGraphTreemapSquarify >> extent [
	^ self row extent
]

{ #category : #accessing }
GtGraphTreemapSquarify >> extent: aPoint [ 
	self 
		assert: [ aPoint isNotNil ] 
		description: [ 'Extent must be non-nil' ].
	self row extent: aPoint.
	self area: aPoint x * aPoint y
]

{ #category : #initialization }
GtGraphTreemapSquarify >> initialize [
	super initialize.
	row := GtGraphTreemapSquarifyRow new nodes: self nodes.
]

{ #category : #accessing }
GtGraphTreemapSquarify >> nodeWeights [
	<return: #Number>
	^ self nodes 
		ifNotEmpty: [ :theNodes | theNodes sum: #weight ]
		ifEmpty: [ 0 ]
]

{ #category : #accessing }
GtGraphTreemapSquarify >> phi [
	<return: #Float>
	^ Phi
]

{ #category : #accessing }
GtGraphTreemapSquarify >> row [
	<return: #GtGraphTreemapSquarifyRow>
	^ row
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarify >> shortestSide [
	^ self extent x min: self extent y
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarify >> squarify: theNodes currentRow: aCurrentRow inRectangle: aRectangle [ 
	| aNode aNewRow |
	aNode := theNodes first.
	aNewRow := aCurrentRow copyWithNode: aNode.
	(aCurrentRow worst < aNewRow worst)
		ifTrue: [ 
			theNodes size = 1 
				ifTrue: [ aRectangle layoutRow: aNewRow in: self ]
				ifFalse: [ self squarify: theNodes allButFirst currentRow: aNewRow inRectangle: aRectangle ] ]
		ifFalse: [ 
			aRectangle layoutRow: aNewRow in: self.
			theNodes size = 1 ifFalse: [ 
				self squarify: theNodes currentRow: GtGraphTreemapSquarifyRow new inRectangle: aRectangle remainingRectangle ] ]
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarify >> squarify: aCollection inRectangle: aGtGraphTreemapSquarifyRectangle [ 
	aCollection ifEmpty: [ ^ self ].
	self 
		squarify: aCollection
		currentRow: GtGraphTreemapSquarifyRow new
		inRectangle: aGtGraphTreemapSquarifyRectangle
]

{ #category : #'seas optimizations' }
GtGraphTreemapSquarify >> updateNode: aNode [
	| theNewNodes aRectangle |
	theNewNodes := self nodes copyWith: aNode.
	aRectangle := GtGraphTreemapSquarifyRectangle position: 0@0 extent: self extent.
	self squarify: theNewNodes inRectangle: aRectangle.
]

{ #category : #accessing }
GtGraphTreemapSquarify >> width: aWidth height: anHeight [ 
	self extent: aWidth @ anHeight
]
