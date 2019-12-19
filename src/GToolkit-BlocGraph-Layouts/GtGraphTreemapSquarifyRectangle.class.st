Class {
	#name : #GtGraphTreemapSquarifyRectangle,
	#superclass : #Object,
	#instVars : [
		'position',
		'extent'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #accessing }
GtGraphTreemapSquarifyRectangle >> extent [
	^ extent
]

{ #category : #accessing }
GtGraphTreemapSquarifyRectangle >> extent: anObject [
	extent := anObject
]

{ #category : #accessing }
GtGraphTreemapSquarifyRectangle >> height [
	^ self extent y
]

{ #category : #testing }
GtGraphTreemapSquarifyRectangle >> isPortrait [
	<return: #Boolean>
	^ self height >= self width
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyRectangle >> layoutRow: aGtGraphTreemapSquarifyRow in: aGtGraphTreemapSquarify [ 
	self isPortrait
		ifTrue: [ self layoutHorizontalRow: aGtGraphTreemapSquarifyRow in: aGtGraphTreemapSquarify ] 
		ifFalse: [ self layoutVerticalRow: aGtGraphTreemapSquarifyRow in: aGtGraphTreemapSquarify ].
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyRectangle >> layoutVerticalRow: aRow in: aTree [ 
	| anOccupiedArea anExtentToOccupy aNextNodePosition aRemainingRectangle |
	anOccupiedArea := aRow occupiedArea.
	anExtentToOccupy := self extent * (anOccupiedArea @ 1).
	aNextNodePosition := self position.
	aRow nodes do: [ :eachNode | 
		| aHeight aWidth |
		aWidth := anExtentToOccupy x.
		aHeight := anExtentToOccupy y * eachNode weight / anOccupiedArea.
		eachNode extent: (aWidth @ aHeight).
		eachNode position: aNextNodePosition.
		aNextNodePosition := eachNode bottomLeft ].
	aRemainingRectangle := self class new
		position: self position + (anExtentToOccupy x @ 0);
		extent: self extent - (anExtentToOccupy x @ 0).
	self remainingRectangle: aRemainingRectangle
]

{ #category : #accessing }
GtGraphTreemapSquarifyRectangle >> position [
	^ position
]

{ #category : #accessing }
GtGraphTreemapSquarifyRectangle >> position: anObject [
	position := anObject
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyRectangle >> remainingRectangle: aGtGraphTreemapSquarifyRectangle [ 
	| remainingRectangle |
	remainingRectangle := aGtGraphTreemapSquarifyRectangle
]

{ #category : #accessing }
GtGraphTreemapSquarifyRectangle >> shortestSide [
	^ self extent x min: self extent y
]

{ #category : #accessing }
GtGraphTreemapSquarifyRectangle >> width [
	^ self extent x
]
