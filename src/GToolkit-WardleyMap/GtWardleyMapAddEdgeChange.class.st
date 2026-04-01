Class {
	#name : #GtWardleyMapAddEdgeChange,
	#superclass : #GtWardleyMapEdgeChange,
	#instVars : [
		'newEdge'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #'instance creation' }
GtWardleyMapAddEdgeChange class >> onMap: aMap andEdge: anEdge [
	| undo |
	undo := self onMap: aMap.
	undo fromNode: anEdge fromNode.
	undo toNode: anEdge toNode.
	undo label: anEdge label.
	undo labelCoordinate: anEdge labelCoordinate.
	undo arrow: anEdge arrow.
	undo isLabelVisible: anEdge isLabelVisible.
	undo width: anEdge width.
	undo color: anEdge color.
	^ undo
]

{ #category : #accessing }
GtWardleyMapAddEdgeChange >> edge [
	^ self newEdge
]

{ #category : #private }
GtWardleyMapAddEdgeChange >> executeNotifying: aBlock [
	| undo |
	newEdge := GtWardleyMapEdgeModel new.
	newEdge fromNode: self fromNode.
	newEdge toNode: self toNode.
	arrow ifNotNil: [ newEdge arrow: arrow ].
	color ifNotNil: [ newEdge color: color ].
	isLabelVisible ifNotNil: [ newEdge isLabelVisible: isLabelVisible ].
	label ifNotNil: [ newEdge label: label ].
	labelCoordinate ifNotNil: [ newEdge labelCoordinate: labelCoordinate ].
	width ifNotNil: [ newEdge width: width ].
	map addEdge: newEdge.
	undo := GtWardleyMapRemoveEdgeChange onMap: map.
	undo edge: newEdge.
	^ undo
]

{ #category : #accessing }
GtWardleyMapAddEdgeChange >> highlightType [
	^ #add
]

{ #category : #accessing }
GtWardleyMapAddEdgeChange >> newEdge [
	^ newEdge
]
