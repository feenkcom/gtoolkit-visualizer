"
I represent graph constraints and allow users to specify logical connections between graph nodes with the help of attached graph edges
"
Class {
	#name : #GtGraphConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'connectedEdges',
		'radius',
		'isEdge',
		'isNode',
		'model',
		'objectsToNodesCache'
	],
	#category : #'GToolkit-BlocGraph-Core'
}

{ #category : #accessing }
GtGraphConstraints >> addConnectedEdge: anEdge [

	(self connectedEdges includes: anEdge) 
		ifFalse: [ self connectedEdges add: anEdge ]
]

{ #category : #'api - graph' }
GtGraphConstraints >> beEdge [
	isEdge := true.
	isNode := false
]

{ #category : #'api - graph' }
GtGraphConstraints >> beNode [
	isEdge := false.
	isNode := true
]

{ #category : #accessing }
GtGraphConstraints >> connectedEdges [
	<return: #OrderedCollection of: #GtGraphEdge>

	^ connectedEdges
]

{ #category : #testing }
GtGraphConstraints >> hasConnectedEdge: anEdge [
	"Return true if a given edge is among my connected edges, false otherwise"
	<return: #Boolean>

	^ self connectedEdges includes: anEdge
]

{ #category : #accessing }
GtGraphConstraints >> incomingEdges [
	^ self connectedEdges select: [ :e | e toElement constraints graph == self ]
]

{ #category : #'initialize-release' }
GtGraphConstraints >> initialize [
	super initialize.
	
	connectedEdges := OrderedCollection new.
	radius := 0.
	isEdge := false.
	isNode := false.
	objectsToNodesCache := Dictionary new
]

{ #category : #testing }
GtGraphConstraints >> isEdge [
	"Return true if an element with these constraints plays a role of an edge, false otherwise"
	<return: #Boolean>

	^ isEdge
]

{ #category : #testing }
GtGraphConstraints >> isNode [
	"Return true if an element with these constraints plays a role of a node, false otherwise"
	<return: #Boolean>

	^ isNode
]

{ #category : #accessing }
GtGraphConstraints >> model [
	^ model
]

{ #category : #accessing }
GtGraphConstraints >> model: anObject [
	model := anObject
]

{ #category : #'api - cache' }
GtGraphConstraints >> nodeAt: anObject ifAbsent: aBlock [
	^ self 
		nodeAt: anObject 
		ifPresent: [ :aNode | ^ aNode ]
		ifAbsent: aBlock
]

{ #category : #'api - cache' }
GtGraphConstraints >> nodeAt: anObject ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	^ objectsToNodesCache
		at: anObject 
		ifPresent: aPresentBlock
		ifAbsent: [
			objectsToNodesCache valuesDo: [ :aChildNode |
				self
					assert: [ aChildNode isKindOf: BlElement ]
					description: [ 'Must be an element' ].
				
				aChildNode graph
					nodeAt: anObject 
					ifPresent: [ :aNode | ^ aPresentBlock value: aNode ] 
					ifAbsent: [ ] ].
	
			anAbsentBlock value ]
]

{ #category : #'api - cache' }
GtGraphConstraints >> nodeAt: anObject put: aNodeElement [
	self
		assert: [ aNodeElement isKindOf: BlElement ]
		description: [ 'Must be an element' ].
	
	^ objectsToNodesCache at: anObject put: aNodeElement
]

{ #category : #accessing }
GtGraphConstraints >> outgoingEdges [
	^ self connectedEdges select: [ :e | e fromElement constraints == self ]
]

{ #category : #accessing }
GtGraphConstraints >> radius [
	^ radius
]

{ #category : #accessing }
GtGraphConstraints >> radius: aNumber [
	radius := aNumber
]

{ #category : #accessing }
GtGraphConstraints >> removeConnectedEdge: anEdge [

	self connectedEdges remove: anEdge ifAbsent: [ "Some tests failed." ]
]
