Class {
	#name : #GtGraphTreemapSliceHorizontalLayout,
	#superclass : #GtGraphTreemapLayout,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #'instance creation' }
GtGraphTreemapSliceHorizontalLayout >> treeFrom: anExtentSpec [
	| anExtent |
	anExtent := anExtentSpec sizeFor: 0@0.
	^ GtGraphTreemapSlice horizontal remainingLength: anExtent x; breadth: anExtent y.
]
