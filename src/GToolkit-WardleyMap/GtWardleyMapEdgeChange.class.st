Class {
	#name : #GtWardleyMapEdgeChange,
	#superclass : #GtWardleyMapChange,
	#instVars : [
		'fromNode',
		'toNode',
		'label',
		'labelCoordinate',
		'arrow',
		'isLabelVisible',
		'width',
		'color'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #accessing }
GtWardleyMapEdgeChange >> arrow [
	^ arrow
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> arrow: aBoolean [
	arrow := aBoolean
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> color [
	^ color
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> color: aColor [
	color := aColor
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> fromNode [
	^ fromNode
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> fromNode: aNode [
	fromNode := aNode
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> isLabelVisible [
	^ isLabelVisible
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> isLabelVisible: aBoolean [
	isLabelVisible := aBoolean
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> label [
	^ label
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> label: aString [
	label := aString
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> labelCoordinate [
	^ labelCoordinate
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> labelCoordinate: aPoint [
	labelCoordinate := aPoint
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> toNode [
	^ toNode
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> toNode: aNode [
	toNode := aNode
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> width [
	^ width
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> width: aNumber [
	width := aNumber
]
