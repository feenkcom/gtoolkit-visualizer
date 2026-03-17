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

{ #category : #'as yet unclassified' }
GtWardleyMapRemoveEdgeChange >> executeNotifying: aBlock [
	| undo |
	undo := GtWardleyMapAddEdgeChange onMap: map.
	undo fromNode: edge fromNode.
	undo toNode: edge toNode.
	undo label: edge label.
	undo labelCoordinate: edge labelCoordinate.
	undo arrow: edge arrow.
	undo isLabelVisible: edge isLabelVisible.
	undo width: edge width.
	undo color: edge color.
	edge removeFromMap.
	^ undo
]
