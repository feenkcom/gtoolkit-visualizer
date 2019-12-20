Class {
	#name : #GtGraphTreemapSquarifiedLayout,
	#superclass : #GtGraphTreemapLayout,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #'instance creation' }
GtGraphTreemapSquarifiedLayout >> treeFrom: anExtent [
	^ GtGraphTreemap squarify extent: anExtent
]
