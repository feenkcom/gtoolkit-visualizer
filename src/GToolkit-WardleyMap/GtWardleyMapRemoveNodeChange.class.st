Class {
	#name : #GtWardleyMapRemoveNodeChange,
	#superclass : #GtWardleyMapChange,
	#instVars : [
		'nodeId'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #private }
GtWardleyMapRemoveNodeChange >> executeNotifying: aBlock [
	| undoNode undo edges node |
	node := self node.
	undoNode := GtWardleyMapAddNodeChange onMap: map andNode: node.
	edges := map edges
			select: [ :each | each toNode == node or: [ each fromNode == node ] ].
	edges notEmpty
		ifTrue: [ undo := RBCompositeRefactoryChange new.
			undo addChange: undoNode.
			edges
				do: [ :each | undo addChange: (GtWardleyMapAddEdgeChange onMap: map andEdge: each) ] ]
		ifFalse: [ undo := undoNode ].
	node removeFromMap.
	^ undo
]

{ #category : #accessing }
GtWardleyMapRemoveNodeChange >> highlightModifications [
	| highlight |
	highlight := self highlight.
	self node addWardleyMapDecoratorModel: highlight
]

{ #category : #accessing }
GtWardleyMapRemoveNodeChange >> highlightType [
	^ #remove
]

{ #category : #accessing }
GtWardleyMapRemoveNodeChange >> node [
	^ map
		nodeWithId: (UUID gtFromString: nodeId)
		ifFound: [ :each | each ]
		ifNone: [  ]
]

{ #category : #accessing }
GtWardleyMapRemoveNodeChange >> node: anObject [
	nodeId := anObject id asString36
]

{ #category : #accessing }
GtWardleyMapRemoveNodeChange >> nodeId [
	^ nodeId
]

{ #category : #accessing }
GtWardleyMapRemoveNodeChange >> nodeId: anObject [
	nodeId := anObject
]
