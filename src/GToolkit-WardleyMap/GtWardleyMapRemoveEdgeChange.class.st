Class {
	#name : #GtWardleyMapRemoveEdgeChange,
	#superclass : #GtWardleyMapChange,
	#instVars : [
		'edge'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #accessing }
GtWardleyMapRemoveEdgeChange >> edge [
	^ edge
]

{ #category : #accessing }
GtWardleyMapRemoveEdgeChange >> edge: anObject [
	edge := anObject
]

{ #category : #private }
GtWardleyMapRemoveEdgeChange >> executeNotifying: aBlock [
	| undo |
	undo := GtWardleyMapAddEdgeChange onMap: map andEdge: edge.
	edge removeFromMap.
	^ undo
]
