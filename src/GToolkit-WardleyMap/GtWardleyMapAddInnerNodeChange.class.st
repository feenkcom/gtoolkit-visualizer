Class {
	#name : #GtWardleyMapAddInnerNodeChange,
	#superclass : #GtWardleyMapChange,
	#instVars : [
		'innerNodeId',
		'outerNodeId'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #copying }
GtWardleyMapAddInnerNodeChange >> copyForPreviewIn: previewMap using: mapping [
	| copy |
	copy := super copyForPreviewIn: previewMap using: mapping.
	self innerNode ifNotNil: [ :node | copy innerNode: (mapping at: node id) ].
	self outerNode ifNotNil: [ :node | copy outerNode: (mapping at: node id) ].
	^ copy
]

{ #category : #private }
GtWardleyMapAddInnerNodeChange >> executeNotifying: aBlock [
	| undoChanges outerNode innerNode |
	undoChanges := OrderedCollection new.
	innerNode := self innerNode.
	outerNode := self outerNode.
	(innerNode notNil and: [ outerNode notNil ])
		ifTrue: [ outerNode isPipelineVisible
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
			outerNode addInnerNode: innerNode ].
	^ RBCompositeRefactoryChange new changes: undoChanges reversed
]

{ #category : #accessing }
GtWardleyMapAddInnerNodeChange >> highlightModifications [
	| highlight |
	self execute.
	highlight := self highlight.
	self innerNode addWardleyMapDecoratorModel: highlight.
	self outerNode addWardleyMapDecoratorModel: highlight
]

{ #category : #accessing }
GtWardleyMapAddInnerNodeChange >> innerNode [
	^ map
		nodeWithId: (UUID gtFromString: innerNodeId)
		ifFound: [ :each | each ]
		ifNone: [  ]
]

{ #category : #accessing }
GtWardleyMapAddInnerNodeChange >> innerNode: aNode [
	innerNodeId := aNode id asString36
]

{ #category : #accessing }
GtWardleyMapAddInnerNodeChange >> innerNodeId [
	^ innerNodeId
]

{ #category : #accessing }
GtWardleyMapAddInnerNodeChange >> innerNodeId: anObject [
	innerNodeId := anObject
]

{ #category : #accessing }
GtWardleyMapAddInnerNodeChange >> outerNode [
	^ map
		nodeWithId: (UUID gtFromString: outerNodeId)
		ifFound: [ :each | each ]
		ifNone: [  ]
]

{ #category : #accessing }
GtWardleyMapAddInnerNodeChange >> outerNode: aNode [
	outerNodeId := aNode id asString36
]

{ #category : #accessing }
GtWardleyMapAddInnerNodeChange >> outerNodeId [
	^ outerNodeId
]

{ #category : #accessing }
GtWardleyMapAddInnerNodeChange >> outerNodeId: anObject [
	outerNodeId := anObject
]
