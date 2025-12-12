"
I represent a rectangle. My height is smaller than my width.
I layout {{gtClass:GtGraphTreemapNode}} along my shorter side (height).
I am used by {{gtClass:GtGraphTreemapSquarifyStep}}.

1. # Example


In the following example, I occupy top-right side of a total area with {{gtExample:GtGraphTreemapLayoutExamples>>#squarifyWithFourNodesFirstArea|label=#nodesCount}} nodes:
{{gtExample:GtGraphTreemapLayoutExamples>>#squarifyWithFourNodesFirstArea|noCode}}


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
	| anExtentToOccupy aNextNodePosition anOriginalArea anOccupiedArea |
	self ifNoSpace: [ ^ self squarifyStepInNoSpace: aStep ].
	anOriginalArea := self original volume.
	anOccupiedArea := anOriginalArea * aStep occupiedWeight.
	anOccupiedArea isZero ifTrue: [ ^ self squarifyStepInNoSpace: aStep ].
	anExtentToOccupy := (anOccupiedArea / self height) @ self height.
	aNextNodePosition := self position.
	aStep nodesDo: [ :eachNode | 
		| aHeight aWidth |
		aWidth := anExtentToOccupy x.
		aHeight := anOriginalArea * eachNode weight / aWidth.
		eachNode extent: (aWidth @ aHeight).
		eachNode position: aNextNodePosition.
		aNextNodePosition := eachNode bottomLeft ].
]

{ #category : #squarifying }
GtGraphTreemapSquarifyLandscapeRectangle >> updateOccupiedArea: aStep [
	| anExtentToOccupy anOccupiedArea anOccupiedRectangle aRemainingRectangle |
	anOccupiedArea := self original volume * aStep occupiedWeight.
	anExtentToOccupy := anOccupiedArea isZero
		ifTrue: [ 0@0 ]
		ifFalse: [ (anOccupiedArea / self height) @ self height ].
	anOccupiedRectangle := self class
		position: self position
		extent: anExtentToOccupy.
	anOccupiedRectangle original: self original.
	self occupiedRectangle: anOccupiedRectangle.
	aRemainingRectangle := self class
		position: self position + (anExtentToOccupy x @ 0)
		extent: self extent - (anExtentToOccupy x @ 0).
	aRemainingRectangle original: self original.
	self remainingRectangle: aRemainingRectangle.

]
