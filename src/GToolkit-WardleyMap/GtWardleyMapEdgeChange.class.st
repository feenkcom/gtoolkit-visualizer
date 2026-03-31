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

{ #category : #copying }
GtWardleyMapEdgeChange >> copyForPreviewIn: previewMap using: mapping [
	| copy |
	copy := super copyForPreviewIn: previewMap using: mapping.
	fromNode ifNotNil: [ copy fromNode: (mapping at: fromNode) ].
	toNode ifNotNil: [ copy toNode: (mapping at: toNode) ].
	^ copy
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> edge [
	self subclassResponsibility
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> fromNode [
	^ fromNode
		ifNil: [ map
				nodeWithId: fromNodeId
				ifFound: [ :each | each ]
				ifNone: [  ] ]
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> fromNode: aNode [
	fromNode := aNode
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> fromNodeId [
	^ fromNodeId ifNil: [ fromNode ifNotNil: [ fromNode id ] ]
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> fromNodeId: anObject [
	fromNodeId := anObject
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> highlightModifications [
	| highlight |
	self execute.
	highlight := GtWardleyMapHighlight new.
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
	^ toNode
		ifNil: [ map
				nodeWithId: toNodeId
				ifFound: [ :each | each ]
				ifNone: [  ] ]
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> toNode: aNode [
	toNode := aNode
]

{ #category : #accessing }
GtWardleyMapEdgeChange >> toNodeId [
	^ toNodeId ifNil: [ toNode ifNotNil: [ toNode id ] ]
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
