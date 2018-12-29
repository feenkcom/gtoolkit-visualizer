Class {
	#name : #GtGradHierarchyEdge,
	#superclass : #GtGradHierarchyElement,
	#instVars : [
		'source',
		'target',
		'reversed',
		'edges'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #'instance creation' }
GtGradHierarchyEdge class >> on: theSourceNode target: theTargetNode [
	<return: #GtGradHierarchyEdge>
	
	^ self new source: theSourceNode; target: theTargetNode
]

{ #category : #accessing }
GtGradHierarchyEdge >> edges [
	^ edges
]

{ #category : #accessing }
GtGradHierarchyEdge >> edges: anObject [
	edges := anObject
]

{ #category : #initialization }
GtGradHierarchyEdge >> initialize [
	super initialize.
	self reversed: false
]

{ #category : #calculating }
GtGradHierarchyEdge >> invert [
	| temp |
	temp := self source.
	self source: self target.
	self target: temp.
	self reversed: (self reversed) not.
]

{ #category : #accessing }
GtGradHierarchyEdge >> nextLayerConnectedElementsOnLayer: aLayer [
	self nextLayerConnectedElements isEmpty
		ifTrue: [ 
			1 to: self rankPositions size do: [ :aNum |
				| elementsCollection |
				elementsCollection := OrderedCollection new.
				self nextLayerConnectedElements at: aNum put: elementsCollection.
				aNum = self rankPositions size
					ifTrue: [ elementsCollection add: self source ]
					ifFalse: [ elementsCollection add: self ]
			]
		].
	^ self nextLayerConnectedElements at: (aLayer - minRank - 1)

]

{ #category : #accessing }
GtGradHierarchyEdge >> positionOnLayer: layer [
	^ self positionsPerLayer at: (layer - minRank -1)
]

{ #category : #accessing }
GtGradHierarchyEdge >> positionOnLayer: layer position: position [
	self positionsPerLayer at: (layer - minRank -1) put: position.
]

{ #category : #accessing }
GtGradHierarchyEdge >> previousLayerConnectedElementsOnLayer: aLayer [
	self previousLayerConnectedElements isEmpty
		ifTrue: [ 
			1 to: self rankPositions size do: [ :aNum |
				| elementsCollection |
				elementsCollection := OrderedCollection new.
				self previousLayerConnectedElements at: aNum put: elementsCollection.
				aNum = 1
					ifTrue: [ elementsCollection add: self target ]
					ifFalse: [ elementsCollection add: self ]
			].
		].
	^ self previousLayerConnectedElements at: (aLayer - minRank - 1)

]

{ #category : #accessing }
GtGradHierarchyEdge >> rankPositionsAt: aLayer [
	^ self rankPositions at: (aLayer - self minRank).
]

{ #category : #accessing }
GtGradHierarchyEdge >> rankPositionsAt: aLayer value: aValue [
	self rankPositions at: (aLayer - self minRank) put: aValue.
]

{ #category : #accessing }
GtGradHierarchyEdge >> reversed [
	^ reversed
]

{ #category : #accessing }
GtGradHierarchyEdge >> reversed: anObject [
	reversed := anObject
]

{ #category : #accessing }
GtGradHierarchyEdge >> source [
	^ source
]

{ #category : #accessing }
GtGradHierarchyEdge >> source: anObject [
	source := anObject
]

{ #category : #accessing }
GtGradHierarchyEdge >> target [
	^ target
]

{ #category : #accessing }
GtGradHierarchyEdge >> target: anObject [
	target := anObject
]

{ #category : #accessing }
GtGradHierarchyEdge >> xPositionAt: aLayer [
	self xPositions at: (aLayer - minRank)
]

{ #category : #accessing }
GtGradHierarchyEdge >> xPositionAt: aLayer value: aValue [
	self xPositions at: (aLayer - minRank) put: aValue  
]

{ #category : #accessing }
GtGradHierarchyEdge >> yPositionAt: aLayer [
	self yPositions at: (aLayer - minRank)
]

{ #category : #accessing }
GtGradHierarchyEdge >> yPositionAt: aLayer value: aValue [
	self yPositions at: (aLayer - minRank) put: aValue  
]
