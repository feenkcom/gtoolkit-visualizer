Class {
	#name : #GtWardleyMapRemoveEdgeChange,
	#superclass : #GtWardleyMapChange,
	#instVars : [
		'fromNodeId',
		'toNodeId'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #accessing }
GtWardleyMapRemoveEdgeChange >> edge [
	| fromUUID toUUID |
	fromUUID := UUID gtFromString: fromNodeId.
	toUUID := UUID gtFromString: toNodeId.
	^ map edges
		detect: [ :each | each fromNode id = fromUUID and: [ each toNode id = toUUID ] ]
		ifNone: [  ]
]

{ #category : #accessing }
GtWardleyMapRemoveEdgeChange >> edge: anObject [
	fromNodeId := anObject fromNode id asString36.
	toNodeId := anObject toNode id asString36
]

{ #category : #private }
GtWardleyMapRemoveEdgeChange >> executeNotifying: aBlock [
	| undo |
	self edge
		ifNotNil: [ :edge | 
			undo := GtWardleyMapAddEdgeChange onMap: map andEdge: edge.
			edge removeFromMap ]
		ifNil: [ undo := (GtWardleyMapAddEdgeChange onMap: map)
					fromNodeId: fromNodeId;
					toNodeId: toNodeId;
					yourself ].
	^ undo
]

{ #category : #accessing }
GtWardleyMapRemoveEdgeChange >> fromNodeId [
	^ fromNodeId
]

{ #category : #accessing }
GtWardleyMapRemoveEdgeChange >> fromNodeId: anObject [
	fromNodeId := anObject
]

{ #category : #accessing }
GtWardleyMapRemoveEdgeChange >> highlightModifications [
	| highlight |
	highlight := self highlight.
	self edge addWardleyMapDecoratorModel: highlight
]

{ #category : #accessing }
GtWardleyMapRemoveEdgeChange >> highlightType [
	^ #remove
]

{ #category : #accessing }
GtWardleyMapRemoveEdgeChange >> toNodeId [
	^ toNodeId
]

{ #category : #accessing }
GtWardleyMapRemoveEdgeChange >> toNodeId: anObject [
	toNodeId := anObject
]
