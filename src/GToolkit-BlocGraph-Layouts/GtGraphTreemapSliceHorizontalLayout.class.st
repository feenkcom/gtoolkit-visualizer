"
I implement an horizontal slice algorithm.
I use ${class:GtGraphTreemapSliceHorizontal}$ to compute ${class:BlElement}$ children positions and extents.

!! Example 

${example:GtGraphTreemapLayoutExamples>>#numbersSliceHorizontal|codeExpanded=false|previewExpanded=true}$


"
Class {
	#name : #GtGraphTreemapSliceHorizontalLayout,
	#superclass : #GtGraphTreemapLayout,
	#category : #'GToolkit-BlocGraph-Layouts-Layouts - Treemap'
}

{ #category : #'instance creation' }
GtGraphTreemapSliceHorizontalLayout >> treeFrom: anExtent [
	^ GtGraphTreemapSlice horizontal length: anExtent x; breadth: anExtent y.
]
