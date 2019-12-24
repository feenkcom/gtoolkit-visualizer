"
I represent a rectangle. My width is smaller than my height.
I layout ${class:GtGraphTreemapNode}$ along my shorter side (width).
I am used by ${class:GtGraphTreemapSquarifyArea}$.

!! Example

In the following example, I occupy top-right side of a total area with ${example:GtGraphTreemapLayoutExamples>>#squarifyWithFourNodesSecondArea|label=#nodesCount}$ nodes:
${example:GtGraphTreemapLayoutExamples>>#squarifyWithFourNodesSecondArea|noCode}$

"
Class {
	#name : #GtGraphTreemapSquarifyPortraitRectangle,
	#superclass : #GtGraphTreemapSquarifyAreaRectangle,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyPortraitRectangle >> layoutArea: anArea [
	| anOriginalArea anOccupiedArea anExtentToOccupy aNextNodePosition aRemainingRectangle anOccupiedRectangle |
	self ifNoSpace: [ ^ self layoutAreaInNoSpace: anArea ].
	anOriginalArea := self original volume.
	anOccupiedArea := anOriginalArea * anArea occupiedWeight.
	anExtentToOccupy := self width @ (anOccupiedArea / self width).
	aNextNodePosition := self position.
	anArea nodes do: [ :eachNode | 
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
