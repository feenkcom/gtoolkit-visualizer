Class {
	#name : #GtWardleyMapRemoveInnerNodeChange,
	#superclass : #GtWardleyMapChange,
	#instVars : [
		'innerNodeId'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #private }
GtWardleyMapRemoveInnerNodeChange >> executeNotifying: aBlock [
	| undo node |
	node := self node.
	undo := (GtWardleyMapAddInnerNodeChange onMap: map)
			outerNode: node pipelineNode;
			innerNode: node.
	node removeFromPipeline.
	^ undo
]

{ #category : #accessing }
GtWardleyMapRemoveInnerNodeChange >> highlightModifications [
	| highlight |
	self execute.
	highlight := self highlight.
	self node addWardleyMapDecoratorModel: highlight
]

{ #category : #accessing }
GtWardleyMapRemoveInnerNodeChange >> innerNodeId [
	^ innerNodeId
]

{ #category : #accessing }
GtWardleyMapRemoveInnerNodeChange >> innerNodeId: anObject [
	innerNodeId := anObject
]

{ #category : #accessing }
GtWardleyMapRemoveInnerNodeChange >> node [
	^ map
		nodeWithId: (UUID gtFromString: innerNodeId)
		ifFound: [ :each | each ]
		ifNone: [  ]
]

{ #category : #accessing }
GtWardleyMapRemoveInnerNodeChange >> node: anObject [
	innerNodeId := anObject id asString36
]
