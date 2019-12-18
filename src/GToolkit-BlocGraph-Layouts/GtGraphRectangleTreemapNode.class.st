Class {
	#name : #GtGraphRectangleTreemapNode,
	#superclass : #Object,
	#instVars : [
		'weight',
		'position',
		'extent'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #accessing }
GtGraphRectangleTreemapNode >> extent [
	^ extent
]

{ #category : #accessing }
GtGraphRectangleTreemapNode >> extent: anObject [
	extent := anObject
]

{ #category : #accessing }
GtGraphRectangleTreemapNode >> position [
	^ position
]

{ #category : #accessing }
GtGraphRectangleTreemapNode >> position: anObject [
	position := anObject
]

{ #category : #accessing }
GtGraphRectangleTreemapNode >> topRight [
	^ self position + (self extent x @ 0)
]

{ #category : #accessing }
GtGraphRectangleTreemapNode >> weight [
	^ weight
]

{ #category : #accessing }
GtGraphRectangleTreemapNode >> weight: anObject [
	weight := anObject
]
