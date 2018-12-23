Class {
	#name : #GtGradHierarchyNode,
	#superclass : #GtGradHierarchyElement,
	#instVars : [
		'incomingEdges',
		'outgoingEdges',
		'hashCode'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #'instance creation' }
GtGradHierarchyNode class >> on: anElement [
	<return: #GtGradHierarchyNode>
	
	^ self new element: anElement
]

{ #category : #'api - layout' }
GtGradHierarchyNode >> addIncomingEdge: anEdge [
	(self incomingEdges includes: anEdge)
		ifFalse: [ self incomingEdges add: anEdge ]

]

{ #category : #'api - layout' }
GtGradHierarchyNode >> addOutgoingEdge: anEdge [
	(self outgoingEdges includes: anEdge)
		ifFalse: [ self outgoingEdges add: anEdge ]

]

{ #category : #accessing }
GtGradHierarchyNode >> hashCode [
	^ hashCode
]

{ #category : #accessing }
GtGradHierarchyNode >> hashCode: anObject [
	hashCode := anObject
]

{ #category : #accessing }
GtGradHierarchyNode >> incomingEdges [
	^ incomingEdges
]

{ #category : #accessing }
GtGradHierarchyNode >> incomingEdges: anObject [
	incomingEdges := anObject
]

{ #category : #initialization }
GtGradHierarchyNode >> initialize [
	super initialize.
	self outgoingEdges: OrderedCollection new.
	self incomingEdges: OrderedCollection new.
	self layer: -1.
]

{ #category : #'layout - computations' }
GtGradHierarchyNode >> isAncestorOfNode: anotherNode [
	(self hashCode isNil or: [ anotherNode isNil or: [anotherNode hashCode isNil]])
		ifTrue: [ ^ false ].
	self hashCode size >= anotherNode hashCode size
		ifTrue: [ ^ false ].
	self hashCode = anotherNode hashCode
		ifTrue: [  ^ true ].
	
	"this code must match the start of the other nodes hash code"
	self hashCode doWithIndex: [ :value :index |
		value ~= (anotherNode hashCode at: index)
			ifTrue: [ ^ false ]
	].
	
	^ true.
	
		
	

]

{ #category : #accessing }
GtGradHierarchyNode >> nextLayerConnectedElementsOnLayer: aLayer [
	self nextLayerConnectedElements isEmpty
		ifTrue: [
			self nextLayerConnectedElements add: OrderedCollection new.
			self incomingEdges do: [ :anEdge |
				(anEdge maxRank = -1 or: [ anEdge maxRank = aLayer + 1 ])
					ifTrue: [
						 self nextLayerConnectedElements first add: anEdge source 
					]
					ifFalse: [
						"Edge spans at least two layers"
						self nextLayerConnectedElements first add: anEdge 
					].
			].
	].
	^ self nextLayerConnectedElements first
]

{ #category : #accessing }
GtGradHierarchyNode >> outgoingEdges [
	^ outgoingEdges
]

{ #category : #accessing }
GtGradHierarchyNode >> outgoingEdges: anObject [
	outgoingEdges := anObject
]

{ #category : #accessing }
GtGradHierarchyNode >> positionOnLayer: layer [
	^ self positionsPerLayer at: layer
]

{ #category : #accessing }
GtGradHierarchyNode >> positionOnLayer: layer position: position [
	self positionsPerLayer at: layer put: position
]

{ #category : #accessing }
GtGradHierarchyNode >> previousLayerConnectedElementsOnLayer: aLayer [
	self previousLayerConnectedElements isEmpty
		ifTrue: [
			| connectedElements |
			connectedElements := OrderedCollection new.
			self previousLayerConnectedElements at: 1 put: connectedElements.
			self outgoingEdges do: [ :anEdge |
				(anEdge minRank = -1 or: [ anEdge minRank = (aLayer - 1) ])
					ifTrue: [
						 connectedElements add: anEdge target
					]
					ifFalse: [
						"Edge spans at least two layers"
						connectedElements add: anEdge 
					].
			].
		].
	^ self previousLayerConnectedElements at: 1.
		
]

{ #category : #accessing }
GtGradHierarchyNode >> rankPositionsAt: aLayer [
	self rankPositions isEmpty
		ifTrue: [ self rankPositions at: 1 put: self layer].
	^ self rankPositions at: 1.
]

{ #category : #accessing }
GtGradHierarchyNode >> rankPositionsAt: aLayer value: aValue [
	self rankPositions at: 1 put: aValue
]

{ #category : #accessing }
GtGradHierarchyNode >> xPositionAt: aLayer [
	xPositions first
]

{ #category : #accessing }
GtGradHierarchyNode >> xPositionAt: aLayer value: aValue [
	xPositions first: aValue.
]
