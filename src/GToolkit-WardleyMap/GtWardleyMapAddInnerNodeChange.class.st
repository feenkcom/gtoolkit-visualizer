Class {
	#name : #GtWardleyMapAddInnerNodeChange,
	#superclass : #GtWardleyMapChange,
	#instVars : [
		'outerNode',
		'innerNode'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #copying }
GtWardleyMapAddInnerNodeChange >> copyForPreviewIn: previewMap using: mapping [
	| copy |
	copy := super copyForPreviewIn: previewMap using: mapping.
	innerNode ifNotNil: [ copy innerNode: (mapping at: innerNode) ].
	outerNode ifNotNil: [ copy outerNode: (mapping at: outerNode) ].
	^ copy
]

{ #category : #private }
GtWardleyMapAddInnerNodeChange >> executeNotifying: aBlock [
	| undoChanges |
	undoChanges := OrderedCollection new.
	outerNode isPipelineVisible
		ifFalse: [ undoChanges
				add: ((GtWardleyMapUpdateNodeChange onMap: map)
						node: outerNode;
						isPipelineVisible: false).
			outerNode isPipelineVisible: true ].
	undoChanges
		add: ((GtWardleyMapUpdateNodeChange onMap: map)
				node: innerNode;
				visibility: innerNode visibility;
				evolution: innerNode evolution).
	undoChanges
		add: ((GtWardleyMapRemoveInnerNodeChange onMap: map) node: innerNode).
	outerNode addInnerNode: innerNode.
	^ RBCompositeRefactoryChange new changes: undoChanges reversed
]

{ #category : #accessing }
GtWardleyMapAddInnerNodeChange >> innerNode [
	^ innerNode
]

{ #category : #accessing }
GtWardleyMapAddInnerNodeChange >> innerNode: aNode [
	innerNode := aNode
]

{ #category : #accessing }
GtWardleyMapAddInnerNodeChange >> outerNode [
	^ outerNode
]

{ #category : #accessing }
GtWardleyMapAddInnerNodeChange >> outerNode: aNode [
	outerNode := aNode
]
