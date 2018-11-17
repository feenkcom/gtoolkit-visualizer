Class {
	#name : #GtGradHierarchyNode,
	#superclass : #GtGradHierarchyElement,
	#instVars : [
		'incomingEdges',
		'outgoingEdges'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #accessing }
GtGradHierarchyNode >> incomingEdges [
	^ incomingEdges
]

{ #category : #accessing }
GtGradHierarchyNode >> incomingEdges: anObject [
	incomingEdges := anObject
]

{ #category : #accessing }
GtGradHierarchyNode >> nextLayerConnectedElementsOnLayer: layer length: length [
	self nextLayerConnectedElements isEmpty
		ifTrue: [
			self nextLayerConnectedElements add: OrderedCollection new.
			self incomingEdges do: [ :anEdge |
				(anEdge maxRank = -1 or: [ anEdge maxRank = layer + 1 ])
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
GtGradHierarchyNode >> previousLayerConnectedElementsOnLayer: layer length: length [
	self previousLayerConnectedElements isEmpty
		ifTrue: [
			self previousLayerConnectedElements add: OrderedCollection new.
			self outgoingEdges do: [ :anEdge |
				(anEdge minRank = -1 or: [ anEdge minRank = layer - 1 ])
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
