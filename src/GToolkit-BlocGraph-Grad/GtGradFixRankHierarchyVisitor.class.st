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
				ifTrue: [ (self rankCollection at: aNode layer) add: aNode.
					aNode maxRank: aNode layout.
					aNode minRank: aNode layout.
					aNode layout: (self rankCollection at: aNode layout) count - 1 ] ].
	(parent isNotNil and: [ connectingEdge isNotNil ])
		ifFalse: [ ^ self ].
	parentNodeRankDifference := parent maxRank - aNode maxRank.
	parentNodeRankDifference > 1
		ifFalse: [ ^ self ].
	connectingEdge maxRank: parent maxRank.
	connectingEdge minRank: aNode maxRank.
	connectingEdge layer: parentNodeRankDifference - 1.
	connectingEdge
		position: (parentNodeRankDifference - 1) @ (parentNodeRankDifference - 1).
	connectingEdge minRank + 1 to: connectingEdge maxRank do: [ :aNum | self rankCollection at: aNum add: connectingEdge ]
]
