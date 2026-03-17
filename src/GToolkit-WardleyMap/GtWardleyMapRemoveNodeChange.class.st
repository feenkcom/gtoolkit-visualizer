Class {
	#name : #GtWardleyMapRemoveNodeChange,
	#superclass : #GtWardleyMapChange,
	#instVars : [
		'node'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #'as yet unclassified' }
GtWardleyMapRemoveNodeChange >> executeNotifying: aBlock [
	| undo |
	undo := GtWardleyMapAddNodeChange onMap: map.

	undo color: node color.
	undo evolution: node evolution.
	node hasId ifTrue: [ undo id: node id ].
	undo isEvolveVisible: node isEvolveVisible.
	undo isPipelineVisible: node isPipelineVisible.
	undo label: node label.
	undo labelCoordinate: node labelModel coordinate.
	undo pipelineCoordinate: node pipelineCoordinate.
	undo visibility: node visibility.

	node removeFromMap.
	^ undo
]

{ #category : #accessing }
GtWardleyMapRemoveNodeChange >> node [
	^ node
]

{ #category : #accessing }
GtWardleyMapRemoveNodeChange >> node: anObject [
	node := anObject
]
