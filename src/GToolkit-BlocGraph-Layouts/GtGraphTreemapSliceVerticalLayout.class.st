Class {
	#name : #GtGraphTreemapSliceVerticalLayout,
	#superclass : #GtGraphTreemapLayout,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #'instance creation' }
GtGraphTreemapSliceVerticalLayout >> treeFrom: anExtentSpec [
	| anExtent |
	anExtent := anExtentSpec sizeFor: 0@0.
	^ GtGraphTreemapSlice vertical remainingLength: anExtent y; breadth: anExtent x.
]
