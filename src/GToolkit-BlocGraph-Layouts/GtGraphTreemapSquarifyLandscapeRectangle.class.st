Class {
	#name : #GtGraphTreemapSquarifyLandscapeRectangle,
	#superclass : #GtGraphTreemapSquarifyRectangle,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyLandscapeRectangle >> layoutRow: aRow in: aTree [ 
	| anOccupiedArea anExtentToOccupy aNextNodePosition aRemainingRectangle |
	anOccupiedArea := aRow occupiedArea asFloat.
	anExtentToOccupy := self extent * (anOccupiedArea @ 1).
	aNextNodePosition := self position.
	aRow nodes do: [ :eachNode | 
		| aHeight aWidth |
		aWidth := anExtentToOccupy x.
		aHeight := anExtentToOccupy y * eachNode weight / anOccupiedArea.
		eachNode extent: (aWidth @ aHeight).
		eachNode position: aNextNodePosition.
		aNextNodePosition := eachNode bottomLeft ].
	aRemainingRectangle := self class
		position: self position + (anExtentToOccupy x @ 0)
		extent: self extent - (anExtentToOccupy x @ 0).
	self remainingRectangle: aRemainingRectangle
]

{ #category : #accessing }
GtGraphTreemapSquarifyLandscapeRectangle >> name [
	^ 'Landscape'
]
