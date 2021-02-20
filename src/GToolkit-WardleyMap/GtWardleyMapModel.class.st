Class {
	#name : #GtWardleyMapModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TGtWardleyMapExportable',
	#classTraits : 'TGtAnnouncer classTrait + TGtWardleyMapExportable classTrait',
	#instVars : [
		'announcer',
		'uniqueIdGenerator',
		'nodes',
		'edges'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #visiting }
GtWardleyMapModel >> acceptVisitor: aWardleyMapVisitor [
	^ aWardleyMapVisitor visitWardleyMap: self
]

{ #category : #'api - edges' }
GtWardleyMapModel >> addEdge: aGtWardleyMapEdgeModel [
	self
		assert: [ aGtWardleyMapEdgeModel notNil ]
		description: [ 'Edge must not be nil' ].
		
	self
		assert: [ self hasNode: aGtWardleyMapEdgeModel fromNode ]
		description: [ 'The edge must be from the existing node' ].
		
	self
		assert: [ self hasNode: aGtWardleyMapEdgeModel toNode ]
		description: [ 'The edge must be from the existing node' ].
	
	"`self` edges are not permitted"
	aGtWardleyMapEdgeModel fromNode = aGtWardleyMapEdgeModel toNode
		ifTrue: [ ^ self ].

	"only one edges between nodes is allowed"
	(self hasEdgeConnecting: aGtWardleyMapEdgeModel fromNode and: aGtWardleyMapEdgeModel toNode)
		ifTrue: [ ^ self ].

	self edges add: aGtWardleyMapEdgeModel.
	self announce: (GtWardleyMapEdgeModelAdded new edgeModel: aGtWardleyMapEdgeModel)
]

{ #category : #'api - nodes' }
GtWardleyMapModel >> addNode: aGtWardleyMapNodeModel [
	nodes add: aGtWardleyMapNodeModel.
	aGtWardleyMapNodeModel id: uniqueIdGenerator next.
	self announce: (GtWardleyMapNodeModelAdded new nodeModel: aGtWardleyMapNodeModel)
]

{ #category : #'api - edges' }
GtWardleyMapModel >> allEdgesConnecting: aWardleyMapNodeModel do: aBlock [
	| theEdges |
	
	theEdges := self edges select: [ :eachEdge | eachEdge fromNode = aWardleyMapNodeModel or: [ eachEdge toNode = aWardleyMapNodeModel ] ].
	theEdges do: aBlock
]

{ #category : #announcer }
GtWardleyMapModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'api - edges' }
GtWardleyMapModel >> edges [
	^ edges
]

{ #category : #testing }
GtWardleyMapModel >> hasEdgeConnecting: aNodeModel and: anotherNodeModel [

	^ self edges anySatisfy: [ :eachEdge |
		(eachEdge fromNode = aNodeModel
			or: [ eachEdge fromNode = anotherNodeModel ])
				and: [ eachEdge toNode = aNodeModel
					or: [ eachEdge toNode = anotherNodeModel ] ] ]
]

{ #category : #testing }
GtWardleyMapModel >> hasNode: aGtWardleyMapNodeModel [
	self
		assert: [ aGtWardleyMapNodeModel notNil ]
		description: [ 'Map node must not be nil' ].
		
	^ self nodes includes: aGtWardleyMapNodeModel
]

{ #category : #initialization }
GtWardleyMapModel >> initialize [
	super initialize.

	uniqueIdGenerator := GtWardleyMapUniqueIdGenerator new.
	nodes := OrderedCollection new.
	edges := OrderedCollection new
]

{ #category : #'api - nodes' }
GtWardleyMapModel >> nodes [
	^ nodes
]

{ #category : #'api - edges' }
GtWardleyMapModel >> removeEdge: aGtWardleyMapEdgeModel [
	self
		assert: [ aGtWardleyMapEdgeModel notNil ]
		description: [ 'Edge must not be nil' ].
		
	self
		assert: [ self hasNode: aGtWardleyMapEdgeModel fromNode ]
		description: [ 'The edge must be from the existing node' ].
		
	self
		assert: [ self hasNode: aGtWardleyMapEdgeModel toNode ]
		description: [ 'The edge must be from the existing node' ].

	self edges remove: aGtWardleyMapEdgeModel ifAbsent: [ ^ self ].
	self announce: (GtWardleyMapEdgeModelRemoved new edgeModel: aGtWardleyMapEdgeModel)
]

{ #category : #'api - nodes' }
GtWardleyMapModel >> removeNode: aGtWardleyMapNodeModel [

	"before removing a node we should remove all connected edges"	
	self allEdgesConnecting: aGtWardleyMapNodeModel do: [ :eachEdge | self removeEdge: eachEdge ].
	nodes remove: aGtWardleyMapNodeModel ifAbsent: [ ^ self ]. 
	self announce: (GtWardleyMapNodeModelRemoved new nodeModel: aGtWardleyMapNodeModel)
]
