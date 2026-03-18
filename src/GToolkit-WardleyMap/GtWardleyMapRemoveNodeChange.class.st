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
	undo := GtWardleyMapAddNodeChange onMap: map andNode: node.
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
