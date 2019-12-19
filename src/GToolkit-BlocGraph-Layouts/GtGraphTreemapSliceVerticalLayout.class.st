Class {
	#name : #GtGraphTreemapSliceVerticalLayout,
	#superclass : #GtGraphTreemapLayout,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #'instance creation' }
GtGraphTreemapSliceVerticalLayout >> treeFrom: anExtent [
	^ GtGraphTreemapSlice vertical length: anExtent y; breadth: anExtent x.
]
