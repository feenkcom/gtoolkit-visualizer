Class {
	#name : #GtWardleyMapRemoveNodeChange,
	#superclass : #GtWardleyMapChange,
	#instVars : [
		'node'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #copying }
GtWardleyMapRemoveNodeChange >> copyForPreviewIn: previewMap using: mapping [
	| copy |
	copy := super copyForPreviewIn: previewMap using: mapping.
	node ifNotNil: [ copy node: (mapping at: node id) ].
	^ copy
]

{ #category : #private }
GtWardleyMapRemoveNodeChange >> executeNotifying: aBlock [
	| undoNode undo edges |
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
	^ node
]

{ #category : #accessing }
GtWardleyMapRemoveNodeChange >> node: anObject [
	node := anObject
]
