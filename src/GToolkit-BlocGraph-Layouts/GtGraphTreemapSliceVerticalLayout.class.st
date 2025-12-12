"
I implement an horizontal slice algorithm.
I use {{gtClass:GtGraphTreemapSliceVertical}} to compute {{gtClass:BlElement}} children positions and extents.

1. # Example 


{{gtExample:GtGraphTreemapLayoutExamples>>#numbersSliceVertical|codeExpanded=false|previewExpanded=true}}


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
