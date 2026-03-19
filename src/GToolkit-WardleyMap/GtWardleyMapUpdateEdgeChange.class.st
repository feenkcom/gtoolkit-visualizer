Class {
	#name : #GtWardleyMapUpdateEdgeChange,
	#superclass : #GtWardleyMapEdgeChange,
	#instVars : [
		'edge'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #accessing }
GtWardleyMapUpdateEdgeChange >> edge [
	^ edge
]

{ #category : #accessing }
GtWardleyMapUpdateEdgeChange >> edge: anEdge [
	edge := anEdge
]

{ #category : #private }
GtWardleyMapUpdateEdgeChange >> executeNotifying: aBlock [
	| undo |
	undo := self copy.
	fromNode
		ifNotNil: [ undo fromNode: edge fromNode.
			edge fromNode: fromNode ].
	toNode
		ifNotNil: [ undo toNode: edge toNode.
			edge toNode: toNode ].
	arrow
		ifNotNil: [ undo arrow: edge arrow.
			edge arrow: arrow ].
	color
		ifNotNil: [ undo color: edge color.
			edge color: color ].
	isLabelVisible
		ifNotNil: [ undo isLabelVisible: edge isLabelVisible.
			edge isLabelVisible: isLabelVisible ].
	label
		ifNotNil: [ undo label: edge label.
			edge label: label ].
	labelCoordinate
		ifNotNil: [ undo labelCoordinate: edge labelCoordinate.
			edge labelCoordinate: labelCoordinate ].
	width
		ifNotNil: [ undo width: edge width.
			edge width: width ].
	^ undo
]
