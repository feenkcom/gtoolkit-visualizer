Class {
	#name : #GtWardleyMapEdgeChange,
	#superclass : #GtWardleyMapChange,
	#instVars : [
		'label',
		'labelCoordinate',
		'arrow',
		'isLabelVisible',
		'width',
		'color',
		'fromNodeId',
		'toNodeId'
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
GtWardleyMapEdgeChange >> edge [
	self subclassResponsibility
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> fromNode [
	^ map
		nodeWithId: (UUID gtFromString: fromNodeId)
		ifFound: [ :each | each ]
		ifNone: [  ]
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> fromNode: aNode [
	fromNodeId := aNode id asString36
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> fromNodeId [
	^ fromNodeId
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> fromNodeId: anObject [
	fromNodeId := anObject
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> highlightModifications [
	| highlight |
	self execute.
	highlight := self highlight.
	self edge addWardleyMapDecoratorModel: highlight
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
	^ map
		nodeWithId: (UUID gtFromString: toNodeId)
		ifFound: [ :each | each ]
		ifNone: [  ]
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> toNode: aNode [
	toNodeId := aNode id asString36
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> toNodeId [
	^ toNodeId
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> toNodeId: anObject [
	toNodeId := anObject
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> width [
	^ width
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> width: aNumber [
	width := aNumber
]
