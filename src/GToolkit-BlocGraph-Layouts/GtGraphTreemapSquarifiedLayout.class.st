"
I implement an horizontal slice algorithm.
I use {{gtClass:GtGraphTreemapSquarify}} to compute {{gtClass:BlElement}} children positions and extents.

1. # Example 


{{gtExample:GtGraphTreemapLayoutExamples>>#numbersSquarified|codeExpanded=false|previewExpanded=true}}


"
Class {
	#name : #GtGraphTreemapSquarifiedLayout,
	#superclass : #GtGraphTreemapLayout,
	#category : #'GToolkit-BlocGraph-Layouts-Layouts - Treemap'
}

{ #category : #initialization }
GtGraphTreemapSquarifiedLayout >> defaultSortFunction [
	^ self descendentSortFunction
]

{ #category : #'instance creation' }
GtGraphTreemapSquarifiedLayout >> treeFrom: anExtent [
	^ GtGraphTreemap squarify extent: anExtent
]
