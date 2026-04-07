Class {
	#name : #GtWardleyMapUpdateEdgeChange,
	#superclass : #GtWardleyMapEdgeChange,
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #accessing }
GtWardleyMapUpdateEdgeChange >> edge [
	| fromId toId |
	fromId := UUID gtFromString: self fromNodeId.
	toId := UUID gtFromString: self toNodeId.
	^ map edges
		detect: [ :each | each fromNode id = fromId and: [ each toNode id = toId ] ]
		ifNone: [  ]
]

{ #category : #accessing }
GtWardleyMapUpdateEdgeChange >> edge: anEdge [
	fromNodeId := anEdge fromNode id asString36.
	toNodeId := anEdge toNode id asString36
]

{ #category : #private }
GtWardleyMapUpdateEdgeChange >> executeNotifying: aBlock [
	| undo |
	undo := self copy.
	self edge
		ifNotNil: [ :edge | 
			self fromNode
				ifNotNil: [ :node | 
					undo fromNode: edge fromNode.
					edge fromNode: node ].
			self toNode
				ifNotNil: [ :node | 
					undo toNode: edge toNode.
					edge toNode: node ].
			arrow
				ifNotNil: [ undo arrow: edge arrow.
					edge arrow: arrow ].
			color
				ifNotNil: [ undo color: edge color.
					edge color: color ].
			isLabelVisible
				ifNotNil: [ undo isLabelVisible: edge isLabelVisible.
					edge isLabelVisible: isLabelVisible ].
			label
				ifNotNil: [ undo label: edge label.
					edge label: label ].
			labelCoordinate
				ifNotNil: [ undo labelCoordinate: edge labelCoordinate.
					edge labelCoordinate: labelCoordinate ].
			width
				ifNotNil: [ undo width: edge width.
					edge width: width ] ].
	^ undo
]
