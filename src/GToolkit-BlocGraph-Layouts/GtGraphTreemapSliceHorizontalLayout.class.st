"
I implement an horizontal slice algorithm.
I use {{gtClass:GtGraphTreemapSliceHorizontal}} to compute {{gtClass:BlElement}} children positions and extents.

1. # Example 


{{gtExample:GtGraphTreemapLayoutExamples>>#numbersSliceHorizontal|codeExpanded=false|previewExpanded=true}}


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
