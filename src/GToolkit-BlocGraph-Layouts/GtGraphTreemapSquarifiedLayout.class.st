Class {
	#name : #GtGraphTreemapSquarifiedLayout,
	#superclass : #GtGraphTreemapLayout,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #initialization }
GtGraphTreemapSquarifiedLayout >> defaultSortFunction [
	^ self descendentSortFunction
]

{ #category : #'instance creation' }
GtGraphTreemapSquarifiedLayout >> treeFrom: anExtent [
	^ GtGraphTreemap squarify extent: anExtent
]
