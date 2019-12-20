Class {
	#name : #GtGraphTreemapSquarifyPortraitRectangle,
	#superclass : #GtGraphTreemapSquarifyAreaRectangle,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyPortraitRectangle >> aspectRatioForWeightRatio: aWeightRatio occupiedExtent: anOccupiedExtent [ 
	| aLenght |
	aLenght := aWeightRatio * anOccupiedExtent x.
	^ (aLenght / anOccupiedExtent y) max: (anOccupiedExtent y / aLenght).
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyPortraitRectangle >> extentOccupiedBy: aRow [
	^ self extent * (1 @ aRow occupiedWeight)
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyPortraitRectangle >> layoutRow: aRow [
	| anOriginalArea anOccupiedArea anExtentToOccupy aNextNodePosition aRemainingRectangle anOccupiedRectangle |
	self ifNoSpace: [ ^ self layoutRowInNoSpace: aRow ].
	anOriginalArea := self original volume.
	anOccupiedArea := anOriginalArea * aRow occupiedWeight.
	anExtentToOccupy := self width @ (anOccupiedArea / self width).
	aNextNodePosition := self position.
	aRow nodes do: [ :eachNode | 
		| aHeight aWidth |
		aHeight := anExtentToOccupy y.
		aWidth := anOriginalArea * eachNode weight / aHeight.
		eachNode extent: (aWidth @ aHeight).
		eachNode position: aNextNodePosition.
		aNextNodePosition := eachNode topRight ].
	aRemainingRectangle := self class
		position: self position + (0 @ anExtentToOccupy y)
		extent: self extent - (0 @ anExtentToOccupy y).
	aRemainingRectangle original: self original.
	self remainingRectangle: aRemainingRectangle.
	anOccupiedRectangle := self class
		position: self position
		extent: anExtentToOccupy.
	anOccupiedRectangle original: self original.
	self occupiedRectangle: anOccupiedRectangle.
]

{ #category : #accessing }
GtGraphTreemapSquarifyPortraitRectangle >> length [
	"gives the length of the shortest side of the remaining subrectangle in which the current row is placed"
	<return: #Number>
	^ self width
]

{ #category : #accessing }
GtGraphTreemapSquarifyPortraitRectangle >> name [
	^ 'Portrait'
]
