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
	self outgoingEdges: Set new.
	self incomingEdges: Set new.
	self layer: -1.
]

{ #category : #'layout - computations' }
GtGradHierarchyNode >> isAncestorOfNode: anotherNode [
	(self hashCode isNil or: [ anotherNode hashCode isNil ])
		ifTrue: [ ^ false ].
	self hashCode count < anotherNode hashCode count
		ifTrue: [ ^ false ].
	self hashCode = anotherNode hashCode
		ifTrue: [  ^ true ].
	
	self hashCode with: anotherNode hashCode do: [ :hashCode1 :hashCode2|
		hashCode1 = hashCode2
			ifFalse: [ ^ false ]
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
			self previousLayerConnectedElements add: OrderedCollection new.
			self outgoingEdges do: [ :anEdge |
				(anEdge minRank = -1 or: [ anEdge minRank = aLayer - 1 ])
					ifTrue: [
						 self previousLayerConnectedElements first add: anEdge target
					]
					ifFalse: [
						"Edge spans at least two layers"
						self previousLayerConnectedElements first  add: anEdge 
					].
			].
		].
	^ self previousLayerConnectedElements first.
		
]

{ #category : #accessing }
GtGradHierarchyNode >> rankPositionsAt: aLayer [
	self rankPositions at: 1.
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
