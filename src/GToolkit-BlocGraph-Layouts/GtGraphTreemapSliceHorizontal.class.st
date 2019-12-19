Class {
	#name : #GtGraphTreemapSliceHorizontal,
	#superclass : #GtGraphTreemapSlice,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #accessing }
GtGraphTreemapSliceHorizontal >> extent [
	<return: #Point>
	^ self nodes 
		ifEmpty: [ self remainingLength @ self breadth ]
		ifNotEmpty: [ self nodes last bottomLeft + (self remainingLength @ 0) ]
]

{ #category : #accessing }
GtGraphTreemapSliceHorizontal >> remainingExtent [
	<return: #Point>
	^ self remainingLength @ self breadth
]

{ #category : #updating }
GtGraphTreemapSliceHorizontal >> updatePositionFor: aNode [
	aNode position: self nodes last topRight
]
