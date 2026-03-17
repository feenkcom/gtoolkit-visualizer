Class {
	#name : #GtWardleyMapAddEdgeChange,
	#superclass : #GtWardleyMapChange,
	#instVars : [
		'fromNode',
		'toNode',
		'label',
		'labelCoordinate',
		'arrow',
		'isLabelVisible',
		'width',
		'newEdge',
		'color'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #accessing }
GtWardleyMapAddEdgeChange >> arrow [
	^ arrow
]

{ #category : #accessing }
GtWardleyMapAddEdgeChange >> arrow: aBoolean [
	arrow := aBoolean
]

{ #category : #accessing }
GtWardleyMapAddEdgeChange >> color [
	^ color
]

{ #category : #accessing }
GtWardleyMapAddEdgeChange >> color: aColor [
	color := aColor
]

{ #category : #private }
GtWardleyMapAddEdgeChange >> executeNotifying: aBlock [
	| undo |
	newEdge := GtWardleyMapEdgeModel new.
	newEdge fromNode: fromNode.
	newEdge toNode: toNode.
	label ifNotNil: [ newEdge label: label ].
	labelCoordinate ifNotNil: [ newEdge labelCoordinate: labelCoordinate ].
	arrow ifNotNil: [ newEdge arrow: arrow ].
	isLabelVisible ifNotNil: [ newEdge isLabelVisible: isLabelVisible ].
	width ifNotNil: [ newEdge width: width ].
	color ifNotNil: [ newEdge color: color ].
	map addEdge: newEdge.
	undo := GtWardleyMapRemoveEdgeChange onMap: map.
	undo edge: newEdge.
	^ undo
]

{ #category : #accessing }
GtWardleyMapAddEdgeChange >> fromNode [
	^ fromNode
]

{ #category : #accessing }
GtWardleyMapAddEdgeChange >> fromNode: aNode [
	fromNode := aNode
]

{ #category : #accessing }
GtWardleyMapAddEdgeChange >> isLabelVisible [
	^ isLabelVisible
]

{ #category : #accessing }
GtWardleyMapAddEdgeChange >> isLabelVisible: aBoolean [
	isLabelVisible := aBoolean
]

{ #category : #accessing }
GtWardleyMapAddEdgeChange >> label [
	^ label
]

{ #category : #accessing }
GtWardleyMapAddEdgeChange >> label: aString [
	label := aString
]

{ #category : #accessing }
GtWardleyMapAddEdgeChange >> labelCoordinate [
	^ labelCoordinate
]

{ #category : #accessing }
GtWardleyMapAddEdgeChange >> labelCoordinate: aPoint [
	labelCoordinate := aPoint
]

{ #category : #accessing }
GtWardleyMapAddEdgeChange >> newEdge [
	^ newEdge
]

{ #category : #accessing }
GtWardleyMapAddEdgeChange >> toNode [
	^ toNode
]

{ #category : #accessing }
GtWardleyMapAddEdgeChange >> toNode: aNode [
	toNode := aNode
]

{ #category : #accessing }
GtWardleyMapAddEdgeChange >> width [
	^ width
]

{ #category : #accessing }
GtWardleyMapAddEdgeChange >> width: aNumber [
	width := aNumber
]
