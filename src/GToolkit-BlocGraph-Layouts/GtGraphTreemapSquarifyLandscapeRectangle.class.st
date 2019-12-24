"
I represent a rectangle. My height is smaller than my width.
I layout ${class:GtGraphTreemapNode}$ along my shorter side (height).
I am used by ${class:GtGraphTreemapSquarifyArea}$.

!! Example

In the following example, I occupy top-right side of a total area with ${example:GtGraphTreemapLayoutExamples>>#squarifyWithFourNodesFirstArea|label=#nodesCount}$ nodes:
${example:GtGraphTreemapLayoutExamples>>#squarifyWithFourNodesFirstArea|noCode}$

"
Class {
	#name : #GtGraphTreemapSquarifyLandscapeRectangle,
	#superclass : #GtGraphTreemapSquarifyAreaRectangle,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

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

{ #category : #squarifying }
GtGraphTreemapSquarifyLandscapeRectangle >> squarifyStep: aStep [
	| anExtentToOccupy aNextNodePosition aRemainingRectangle anOriginalArea anOccupiedArea anOccupiedRectangle |
	self ifNoSpace: [ ^ self squarifyStepInNoSpace: aStep ].
	anOriginalArea := self original volume.
	anOccupiedArea := anOriginalArea * aStep occupiedWeight.
	anExtentToOccupy := (anOccupiedArea / self height) @ self height.
	aNextNodePosition := self position.
	aStep nodesDo: [ :eachNode | 
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
	self remainingRectangle: aRemainingRectangle.
	anOccupiedRectangle := self class
		position: self position
		extent: anExtentToOccupy.
	anOccupiedRectangle original: self original.
	self occupiedRectangle: anOccupiedRectangle.
]

{ #category : #squarifying }
GtGraphTreemapSquarifyLandscapeRectangle >> updateOccupiedArea: aStep [
	| anExtentToOccupy anOccupiedArea anOccupiedRectangle |
	anOccupiedArea := self original volume * aStep occupiedWeight.
	anExtentToOccupy := (anOccupiedArea / self height) @ self height.
	anOccupiedRectangle := self class
		position: self position
		extent: anExtentToOccupy.
	anOccupiedRectangle original: self original.
	self occupiedRectangle: anOccupiedRectangle.
]
