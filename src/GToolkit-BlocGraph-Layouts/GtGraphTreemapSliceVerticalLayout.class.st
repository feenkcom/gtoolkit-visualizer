"
I implement an horizontal slice algorithm.
I use ${class:GtGraphTreemapSliceVertical}$ to compute ${class:BlElement}$ children positions and extents.

!! Example 

${example:GtGraphTreemapLayoutExamples>>#numbersSliceVertical|codeExpanded=false|previewExpanded=true}$


"
Class {
	#name : #GtGraphTreemapSliceVerticalLayout,
	#superclass : #GtGraphTreemapLayout,
	#category : #'GToolkit-BlocGraph-Layouts-Layouts - Treemap'
}

{ #category : #'instance creation' }
GtGraphTreemapSliceVerticalLayout >> treeFrom: anExtent [
	^ GtGraphTreemapSlice vertical length: anExtent y; breadth: anExtent x.
]
