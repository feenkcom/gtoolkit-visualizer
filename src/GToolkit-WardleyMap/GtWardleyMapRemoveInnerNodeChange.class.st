Class {
	#name : #GtWardleyMapRemoveInnerNodeChange,
	#superclass : #GtWardleyMapChange,
	#instVars : [
		'node'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #private }
GtWardleyMapRemoveInnerNodeChange >> executeNotifying: aBlock [
	| undo |
	undo := (GtWardleyMapAddInnerNodeChange onMap: map)
			outerNode: node pipelineNode;
			innerNode: node.
	node removeFromPipeline.
	^ undo
]

{ #category : #accessing }
GtWardleyMapRemoveInnerNodeChange >> node [
	^ node
]

{ #category : #accessing }
GtWardleyMapRemoveInnerNodeChange >> node: anObject [
	node := anObject
]
