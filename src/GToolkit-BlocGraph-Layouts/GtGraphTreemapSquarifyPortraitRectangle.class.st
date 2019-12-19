Class {
	#name : #GtGraphTreemapSquarifyPortraitRectangle,
	#superclass : #GtGraphTreemapSquarifyRectangle,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyPortraitRectangle >> layoutRow: aRow in: aTree [
	| anOccupiedArea anExtentToOccupy aNextNodePosition aRemainingRectangle |
	anOccupiedArea := aRow occupiedArea asFloat.
	anExtentToOccupy := self extent * (1 @ anOccupiedArea).
	aNextNodePosition := self position.
	aRow nodes do: [ :eachNode | 
		| aHeight aWidth |
		aWidth := anExtentToOccupy x.
		aHeight := anExtentToOccupy y * eachNode weight / anOccupiedArea.
		eachNode extent: (aWidth @ aHeight).
		eachNode position: aNextNodePosition.
		aNextNodePosition := eachNode bottomLeft ].
	aRemainingRectangle := self class
		position: self position + (0 @ anExtentToOccupy y)
		extent: self extent - (0 @ anExtentToOccupy y).
	self remainingRectangle: aRemainingRectangle
]

{ #category : #accessing }
GtGraphTreemapSquarifyPortraitRectangle >> name [
	^ 'Portrait'
]
