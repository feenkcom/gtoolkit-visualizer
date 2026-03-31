Class {
	#name : #GtWardleyMapRemoveInnerNodeChange,
	#superclass : #GtWardleyMapChange,
	#instVars : [
		'node'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #copying }
GtWardleyMapRemoveInnerNodeChange >> copyForPreviewIn: previewMap using: mapping [
	| copy |
	copy := super copyForPreviewIn: previewMap using: mapping.
	node ifNotNil: [ copy node: (mapping at: node) ].
	^ copy
]

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
GtWardleyMapRemoveInnerNodeChange >> highlightModifications [
	| highlight |
	self execute.
	highlight := GtWardleyMapHighlight new.
	self node addWardleyMapDecoratorModel: highlight
]

{ #category : #accessing }
GtWardleyMapRemoveInnerNodeChange >> node [
	^ node
]

{ #category : #accessing }
GtWardleyMapRemoveInnerNodeChange >> node: anObject [
	node := anObject
]
