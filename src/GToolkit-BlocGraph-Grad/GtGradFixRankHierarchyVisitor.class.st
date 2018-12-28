Class {
	#name : #GtGradFixRankHierarchyVisitor,
	#superclass : #GtGradHierarchyVisitor,
	#instVars : [
		'rankCollection'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #accessing }
GtGradFixRankHierarchyVisitor >> addTorankCollectionAt: anIndex value: aValue [
	| nodesCollection |
	nodesCollection := self rankCollection at: anIndex.
	(nodesCollection includes: aValue)
		ifFalse: [ nodesCollection add: aValue ]

]

{ #category : #accessing }
GtGradFixRankHierarchyVisitor >> rankCollection [
	^ rankCollection
]

{ #category : #accessing }
GtGradFixRankHierarchyVisitor >> rankCollection: anObject [
	rankCollection := anObject
]

{ #category : #visiting }
GtGradFixRankHierarchyVisitor >> visit: aNode parent: theParentNode connectingEdge: connectingEdge layer: layer visited: visited [
	| parentNodeRankDifference |
	visited
		ifFalse: [ (aNode maxRank < 0 and: [ aNode minRank < 0 ])
				ifTrue: [
					"it is necessary to add 1 because indexes start at 1"
					self addTorankCollectionAt: (aNode layer + 1) value: aNode.
					aNode maxRank: aNode layer.
					aNode minRank: aNode layer.
					aNode layer: (self rankCollection at: aNode maxRank + 1) size - 1.
					] 
				].
	(theParentNode isNotNil and: [ connectingEdge isNotNil ])
		ifFalse: [ ^ self ].
	parentNodeRankDifference := theParentNode maxRank - aNode maxRank.
	parentNodeRankDifference > 1
		ifFalse: [ ^ self ].
	connectingEdge maxRank: theParentNode maxRank.
	connectingEdge minRank: aNode maxRank.
	connectingEdge minRank + 2 to: connectingEdge maxRank do: [ :aNum |
		self addTorankCollectionAt: aNum value: connectingEdge.
		connectingEdge rankPositionsAt: aNum value: (rankCollection at: aNum) size - 1
		]
]
