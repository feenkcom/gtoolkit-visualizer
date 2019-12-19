Class {
	#name : #GtGraphTreemapLayout,
	#superclass : #GtGraphLayout,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #constraints }
GtGraphTreemapLayout class >> constraints [
	^ GtGraphTreemapLayoutConstraints new
]

{ #category : #factory }
GtGraphTreemapLayout class >> horizontalSlice [
	^ GtGraphTreemapSliceHorizontalLayout new
]

{ #category : #factory }
GtGraphTreemapLayout class >> verticalSlice [
	^ GtGraphTreemapSliceVerticalLayout new
]

{ #category : #hook }
GtGraphTreemapLayout >> doExecute: elements with: anExtentSpec [
	| aTree aTotalWeight |
	aTree := self treeFrom: anExtentSpec.
	aTotalWeight := elements sum: [ :eachElement | eachElement constraints treemap weight ].
	elements do: [ :eachElement | 
		| aNode |
		aNode := GtGraphTreemapNode new.
		aNode weight: (eachElement constraints treemap weight / aTotalWeight).
		aTree addNode: aNode.
		eachElement measuredBounds position: aNode position; extent: aNode extent ].
]

{ #category : #'instance creation' }
GtGraphTreemapLayout >> treeFrom: anExtentSpec [
	<return: #GtGraphTreemapSlice>
	^ self subclassResponsibility
]
