Class {
	#name : #GtWardleyMapUpdateEdgeChange,
	#superclass : #GtWardleyMapEdgeChange,
	#instVars : [
		'edge'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #copying }
GtWardleyMapUpdateEdgeChange >> copyForPreviewIn: previewMap using: mapping [
	| copy |
	copy := super copyForPreviewIn: previewMap using: mapping.
	edge ifNotNil: [ copy edge: (mapping at: edge) ].
	^ copy
]

{ #category : #accessing }
GtWardleyMapUpdateEdgeChange >> edge [
	^ edge
		ifNil: [ edge := map edges
					detect: [ :each | each fromNode id = self fromNodeId and: [ each toNode id = self toNodeId ] ]
					ifNone: [  ] ]
]

{ #category : #accessing }
GtWardleyMapUpdateEdgeChange >> edge: anEdge [
	edge := anEdge
]

{ #category : #private }
GtWardleyMapUpdateEdgeChange >> executeNotifying: aBlock [
	| undo |
	undo := self copy.
	self fromNode
		ifNotNil: [ :node | 
			undo fromNode: self edge fromNode.
			self edge fromNode: node ].
	self toNode
		ifNotNil: [ :node | 
			undo toNode: self edge toNode.
			self edge toNode: node ].
	arrow
		ifNotNil: [ undo arrow: self edge arrow.
			self edge arrow: arrow ].
	color
		ifNotNil: [ undo color: self edge color.
			self edge color: color ].
	isLabelVisible
		ifNotNil: [ undo isLabelVisible: self edge isLabelVisible.
			self edge isLabelVisible: isLabelVisible ].
	label
		ifNotNil: [ undo label: self edge label.
			self edge label: label ].
	labelCoordinate
		ifNotNil: [ undo labelCoordinate: self edge labelCoordinate.
			self edge labelCoordinate: labelCoordinate ].
	width
		ifNotNil: [ undo width: self edge width.
			self edge width: width ].
	^ undo
]
