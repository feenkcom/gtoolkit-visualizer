"
I split an area vertically according to {{gtMethod:GtGraphTreemapNode>>#weight}} node values.

1. # Example 


The following example shows an area with three nodes: 
{{gtExample:GtGraphTreemapLayoutExamples>>#sliceVerticalWithThreeNodes|codeExpanded=false|previewExpanded=true}}.


"
Class {
	#name : #GtGraphTreemapSliceVertical,
	#superclass : #GtGraphTreemapSlice,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #accessing }
GtGraphTreemapSliceVertical >> extent [
	<return: #Point>
	^ self breadth @ self length
]

{ #category : #accessing }
GtGraphTreemapSliceVertical >> remainingExtent [
	<return: #Point>
	^ self nodes 
		ifNotEmpty: [ self extent - self nodes last bottomLeft ]
		ifEmpty: [ self extent ]
]

{ #category : #updating }
GtGraphTreemapSliceVertical >> updateExtentFor: aNode [
	| aNodeLength |
	aNodeLength := self length * aNode weight.
	aNode extent: self breadth @ aNodeLength
]

{ #category : #updating }
GtGraphTreemapSliceVertical >> updatePositionFor: aNode [
	aNode position: self nodes last bottomLeft
]
