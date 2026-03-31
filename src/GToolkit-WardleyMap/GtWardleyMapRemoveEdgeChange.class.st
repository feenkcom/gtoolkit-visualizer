Class {
	#name : #GtWardleyMapRemoveEdgeChange,
	#superclass : #GtWardleyMapChange,
	#instVars : [
		'edge'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #copying }
GtWardleyMapRemoveEdgeChange >> copyForPreviewIn: previewMap using: mapping [
	| copy |
	copy := super copyForPreviewIn: previewMap using: mapping.
	edge ifNotNil: [ copy edge: (mapping at: edge) ].
	^ copy
]

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
