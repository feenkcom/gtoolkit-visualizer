Class {
	#name : #GtGraphTreemapSliceVertical,
	#superclass : #GtGraphTreemapSlice,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #accessing }
GtGraphTreemapSliceVertical >> extent [
	<return: #Point>
	^ self nodes 
		ifEmpty: [ self breadth @ self remainingLength ]
		ifNotEmpty: [ self nodes last position + self nodes last extent + (self breadth @ self remainingLength) ]
]

{ #category : #accessing }
GtGraphTreemapSliceVertical >> remainingExtent [
	<return: #Point>
	^ self breadth @ self remainingLength
]

{ #category : #updating }
GtGraphTreemapSliceVertical >> updatePositionFor: aNode [
	aNode position: self nodes last bottomLeft
]
