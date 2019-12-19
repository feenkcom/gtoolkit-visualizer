Class {
	#name : #GtGraphTreemapSliceHorizontalLayout,
	#superclass : #GtGraphTreemapLayout,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #'instance creation' }
GtGraphTreemapSliceHorizontalLayout >> treeFrom: anExtent [
	^ GtGraphTreemapSlice horizontal length: anExtent x; breadth: anExtent y.
]
