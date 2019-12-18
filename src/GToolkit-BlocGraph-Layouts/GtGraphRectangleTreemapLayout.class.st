Class {
	#name : #GtGraphRectangleTreemapLayout,
	#superclass : #GtGraphLayout,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #constraints }
GtGraphRectangleTreemapLayout class >> constraints [
	^ GtGraphRectangleTreemapLayoutConstraints new
]

{ #category : #hook }
GtGraphRectangleTreemapLayout >> doExecute: elements with: anExtentSpec [
	| anExtent aTree aSum |
	anExtent := anExtentSpec sizeFor: 0@0.
	aTree := GtGraphRectangleSliceTreemap new remainingLength: anExtent x; breadth: anExtent y.
	aSum := elements sum: [ :eachElement | eachElement constraints treemap weight ].
	elements do: [ :eachElement | 
		| aNode |
		aNode := GtGraphRectangleTreemapNode new.
		aNode weight: (eachElement constraints treemap weight / aSum).
		aTree addNode: aNode.
		eachElement measuredBounds position: aNode position; extent: aNode extent ].
]
