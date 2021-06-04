"
I represent a rectangle. My width is smaller than my height.
I layout {{gtClass:GtGraphTreemapNode}} along my shorter side (width).
I am used by {{gtClass:GtGraphTreemapSquarifyStep}}.

1. # Example


In the following example, I occupy top-right side of a total area with {{gtExample:GtGraphTreemapLayoutExamples>>#squarifyWithFourNodesSecondArea|label=#nodesCount}} nodes:
{{gtExample:GtGraphTreemapLayoutExamples>>#squarifyWithFourNodesSecondArea|noCode}}


"
Class {
	#name : #GtGraphTreemapSquarifyPortraitRectangle,
	#superclass : #GtGraphTreemapSquarifyAreaRectangle,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

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

{ #category : #squarifying }
GtGraphTreemapSquarifyPortraitRectangle >> squarifyStep: aStep [
	| anOriginalArea anOccupiedArea anExtentToOccupy aNextNodePosition |
	self ifNoSpace: [ ^ self squarifyStepInNoSpace: aStep ].
	anOriginalArea := self original volume.
	anOccupiedArea := anOriginalArea * aStep occupiedWeight.
	anOccupiedArea isZero ifTrue: [ ^ self squarifyStepInNoSpace: aStep ].
	anExtentToOccupy := self width @ (anOccupiedArea / self width).
	aNextNodePosition := self position.
	aStep nodesDo: [ :eachNode | 
		| aHeight aWidth |
		aHeight := anExtentToOccupy y.
		aWidth := anOriginalArea * eachNode weight / aHeight.
		eachNode extent: (aWidth @ aHeight).
		eachNode position: aNextNodePosition.
		aNextNodePosition := eachNode topRight ].
]

{ #category : #squarifying }
GtGraphTreemapSquarifyPortraitRectangle >> updateOccupiedArea: aStep [
	| anOccupiedArea anExtentToOccupy anOccupiedRectangle aRemainingRectangle |
	anOccupiedArea := self original volume * aStep occupiedWeight.
	anExtentToOccupy := anOccupiedArea isZero 
		ifTrue: [ 0@0 ]
		ifFalse: [ self width @ (anOccupiedArea / self width) ].
	anOccupiedRectangle := self class
		position: self position
		extent: anExtentToOccupy.
	anOccupiedRectangle original: self original.
	self occupiedRectangle: anOccupiedRectangle.
	aRemainingRectangle := self class
		position: self position + (0 @ anExtentToOccupy y)
		extent: self extent - (0 @ anExtentToOccupy y).
	aRemainingRectangle original: self original.
	self remainingRectangle: aRemainingRectangle.

]
