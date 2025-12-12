"
I split an area horizontally according to {{gtMethod:GtGraphTreemapNode>>#weight}} node values.

1. # Example 


The following example shows an area with three nodes: 
{{gtExample:GtGraphTreemapLayoutExamples>>#sliceHorizontalWithThreeNodes|codeExpanded=false|previewExpanded=true}}.


"
Class {
	#name : #GtGraphTreemapSliceHorizontal,
	#superclass : #GtGraphTreemapSlice,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #accessing }
GtGraphTreemapSliceHorizontal >> extent [
	<return: #Point>
	^ self length @ self breadth
]

{ #category : #accessing }
GtGraphTreemapSliceHorizontal >> remainingExtent [
	<return: #Point>
	^ self nodes 
		ifNotEmpty: [ self extent - (self nodes last topRight @ 0) ]
		ifEmpty: [ self extent ]
]

{ #category : #updating }
GtGraphTreemapSliceHorizontal >> updateExtentFor: aNode [
	| aNodeLength |
	aNodeLength := self length * aNode weight.
	aNode extent: aNodeLength @ self breadth
]

{ #category : #updating }
GtGraphTreemapSliceHorizontal >> updatePositionFor: aNode [
	aNode position: self nodes last topRight
]
