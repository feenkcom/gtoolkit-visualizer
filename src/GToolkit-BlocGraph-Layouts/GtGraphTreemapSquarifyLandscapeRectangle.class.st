Class {
	#name : #GtGraphTreemapSquarifyLandscapeRectangle,
	#superclass : #GtGraphTreemapSquarifyRectangle,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #accessing }
GtGraphTreemapSquarifyLandscapeRectangle >> aspectRatioForWeightRatio: aWeightRatio occupiedExtent: anOccupiedExtent [ 
	| aLenght |
	aLenght := aWeightRatio * anOccupiedExtent y.
	^ (aLenght / anOccupiedExtent x) max: (anOccupiedExtent x / aLenght).
]

{ #category : #accessing }
GtGraphTreemapSquarifyLandscapeRectangle >> extentOccupiedBy: aRow [
	^ self extent * (aRow occupiedWeight @ 1)
]

{ #category : #accessing }
GtGraphTreemapSquarifyLandscapeRectangle >> layoutRow: aRow [
	| anExtentToOccupy aNextNodePosition aRemainingRectangle anOriginalArea anOccupiedArea |
	anOriginalArea := self original volume.
	anOccupiedArea := anOriginalArea * aRow occupiedWeight.
	anExtentToOccupy := (anOccupiedArea / self height) @ self height.
	aNextNodePosition := self position.
	aRow nodes do: [ :eachNode | 
		| aHeight aWidth |
		aWidth := anExtentToOccupy x.
		aHeight := anOriginalArea * eachNode weight / aWidth.
		eachNode extent: (aWidth @ aHeight).
		eachNode position: aNextNodePosition.
		aNextNodePosition := eachNode bottomLeft ].
	aRemainingRectangle := self class
		position: self position + (anExtentToOccupy x @ 0)
		extent: self extent - (anExtentToOccupy x @ 0).
	aRemainingRectangle original: self original.
	self remainingRectangle: aRemainingRectangle
]

{ #category : #accessing }
GtGraphTreemapSquarifyLandscapeRectangle >> length [
	"gives the length of the shortest side of the remaining subrectangle in which the current row is placed"
	<return: #Number>
	^ self height
]

{ #category : #accessing }
GtGraphTreemapSquarifyLandscapeRectangle >> name [
	^ 'Landscape'
]
