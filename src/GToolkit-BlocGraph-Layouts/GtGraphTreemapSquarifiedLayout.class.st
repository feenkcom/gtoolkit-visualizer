"
I implement an horizontal slice algorithm.
I use ${class:GtGraphTreemapSquarify}$ to compute ${class:BlElement}$ children positions and extents.

!! Example 

${example:GtGraphTreemapLayoutExamples>>#numbersSquarified|codeExpanded=false|previewExpanded=true}$


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
