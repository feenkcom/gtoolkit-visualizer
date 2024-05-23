Class {
	#name : #GtWardleyMapNodeEvolveTypeTransformer,
	#superclass : #Object,
	#instVars : [
		'sourceNode',
		'targetNode',
		'incomingEdge',
		'mapModel'
	],
	#category : #'GToolkit-WardleyMap-Helpers - Node Type'
}

{ #category : #asserting }
GtWardleyMapNodeEvolveTypeTransformer >> assertIncomingEdge [
	self
		assert: [ self incomingEdge isNotNil ]
		description: [ 'Incoming edge must be non-nil' ].
	self
		assert: [ self incomingEdge fromNode == self sourceNode ]
		description: [ 'Incoming edge from-node and source node must be identical' ].
	self
		assert: [ self incomingEdge toNode == self targetNode ]
		description: [ 'Incoming edge to-node and target node must be identical' ]
]

{ #category : #asserting }
GtWardleyMapNodeEvolveTypeTransformer >> assertSourceNode [
	self
		assert: [ self sourceNode isNotNil ]
		description: [ 'Source node must be non-nil' ].
	self
		assert: [ self sourceNode parent isNotNil ]
		description: [ 'Source node parent must be non-nil' ].
	self
		assert: [ self sourceNode parent == self targetNode parent ]
		description: [ 'Source and target nodes must have identical parent' ]
]

{ #category : #asserting }
GtWardleyMapNodeEvolveTypeTransformer >> assertTargetNode [
	self
		assert: [ self targetNode isNotNil ]
		description: [ 'Target node must be non-nil' ].
	self
		assert: [ self targetNode parent isNotNil ]
		description: [ 'Target node parent must be non-nil' ]
]

{ #category : #'api - transformation' }
GtWardleyMapNodeEvolveTypeTransformer >> ensureIncomingEdge [
	self incomingEdge ifNotNil: [ ^ self ].
	
	self possibleIncomingEdges ifNotEmpty: [ :aCollection | 
		self incomingEdge: aCollection anyOne ]
]

{ #category : #'api - transformation' }
GtWardleyMapNodeEvolveTypeTransformer >> ensureSourceNode [
	self sourceNode ifNotNil: [ ^ self ].
	self ensureIncomingEdge.
	
	self incomingEdge ifNotNil: [ :anEdge | 
		self sourceNode: anEdge fromNode ]
]

{ #category : #accessing }
GtWardleyMapNodeEvolveTypeTransformer >> incomingEdge [
	^ incomingEdge
]

{ #category : #accessing }
GtWardleyMapNodeEvolveTypeTransformer >> incomingEdge: anObject [
	incomingEdge := anObject
]

{ #category : #accessing }
GtWardleyMapNodeEvolveTypeTransformer >> mapModel [
	^ mapModel
]

{ #category : #accessing }
GtWardleyMapNodeEvolveTypeTransformer >> mapModel: anObject [
	mapModel := anObject
]

{ #category : #'api - transformation' }
GtWardleyMapNodeEvolveTypeTransformer >> possibleIncomingEdges [
	self assertTargetNode.

	^ self mapModel edges
		select: [ :each | each toNode == self targetNode ]
]

{ #category : #'api - transformation' }
GtWardleyMapNodeEvolveTypeTransformer >> possibleSourceNodes [
	self assertTargetNode.

	^ self possibleIncomingEdges collect: #fromNode as: Set
]

{ #category : #accessing }
GtWardleyMapNodeEvolveTypeTransformer >> sourceNode [
	^ sourceNode
]

{ #category : #accessing }
GtWardleyMapNodeEvolveTypeTransformer >> sourceNode: anObject [
	sourceNode := anObject
]

{ #category : #accessing }
GtWardleyMapNodeEvolveTypeTransformer >> targetNode [
	^ targetNode
]

{ #category : #accessing }
GtWardleyMapNodeEvolveTypeTransformer >> targetNode: anObject [
	targetNode := anObject
]

{ #category : #'api - transformation' }
GtWardleyMapNodeEvolveTypeTransformer >> transform [
	| aType |
	self assertTargetNode.

	self ensureIncomingEdge.
	self ensureSourceNode.

	self assertSourceNode.
	self assertIncomingEdge.

	aType := GtWardleyMapNodeEvolveTargetType new
			sourceNode: self sourceNode;
			targetNode: self targetNode.

	self possibleIncomingEdges do: [ :eachEdge | 
		eachEdge == incomingEdge ifFalse: [ 
			self mapModel removeEdge: eachEdge
		]
	].
			
	self targetNode type: aType.
]
