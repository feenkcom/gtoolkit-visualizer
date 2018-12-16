Class {
	#name : #GtGradFixRankHierarchyVisitor,
	#superclass : #GtGradHierarchyVisitor,
	#instVars : [
		'rankCollection'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #accessing }
GtGradFixRankHierarchyVisitor >> rankCollection [
	^ rankCollection
]

{ #category : #accessing }
GtGradFixRankHierarchyVisitor >> rankCollection: anObject [
	rankCollection := anObject
]

{ #category : #visiting }
GtGradFixRankHierarchyVisitor >> visit: aNode parent: parent connectingEdge: connectingEdge layer: layer visited: visited [
	| parentNodeRankDifference |
	visited
		ifFalse: [ (aNode maxRank < 0 and: [ aNode minRank < 0 ])
				ifTrue: [
					"it is necessary to add 1 because indexes start at 1"
					(self rankCollection at: aNode layer + 1) add: aNode.
					aNode maxRank: aNode layer.
					aNode minRank: aNode layer.
					aNode layer: (self rankCollection at: aNode maxRank + 1) size - 1] ].
	(parent isNotNil and: [ connectingEdge isNotNil ])
		ifFalse: [ ^ self ].
	parentNodeRankDifference := parent maxRank - aNode maxRank.
	parentNodeRankDifference > 1
		ifFalse: [ ^ self ].
	connectingEdge maxRank: parent maxRank.
	connectingEdge minRank: aNode maxRank.
	connectingEdge minRank + 1 to: connectingEdge maxRank - 1 do: [ :aNum |
		self rankCollection at: aNum add: connectingEdge.
		connectingEdge rankPositionsAt: aNum value: rankCollection count
		]
]
