Class {
	#name : #GtGradDominanceTreeForest,
	#superclass : #GtGradTreeForest,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'private - depth-first-search' }
GtGradDominanceTreeForest class >> dfs: theCurrentNode visited: aVisitedDictionary [
	| currentDepth |
	currentDepth := theCurrentNode depth.
	theCurrentNode element graph hasNodesAlongOutgoingEdges
		ifTrue: [ theCurrentNode element graph nodesAlongOutgoingEdges
				do: [ :aNodeElement | 
					| aTreeNode |
					(aVisitedDictionary includesKey: aNodeElement)
						ifTrue: [ | oldDepth |
							aTreeNode := aVisitedDictionary at: aNodeElement.
							oldDepth := aTreeNode parent depth.
							currentDepth > oldDepth
								ifTrue: [ 
									aTreeNode parent remove: aTreeNode.
									theCurrentNode add: aTreeNode.
									self dfs: aTreeNode visited: aVisitedDictionary
								] ]
						ifFalse: [ aTreeNode := GtGradTreeNode on: aNodeElement.
							theCurrentNode add: aTreeNode.
							aVisitedDictionary at: aNodeElement put: aTreeNode.
							self dfs: aTreeNode visited: aVisitedDictionary
							] ] ]
]

{ #category : #'instance-creation' }
GtGradDominanceTreeForest class >> from: aCollectionOfElements separateSubtrees: separateSubtrees [
	"Create a forest of node trees using depth-first-search algorithm"
	| allTrees visitedDictionary |

	allTrees := OrderedDictionary new.
	visitedDictionary := IdentityDictionary new.


	aCollectionOfElements do: [ :aNodeElement |
		((visitedDictionary includesKey: aNodeElement) or: [ aNodeElement graph hasNodesAlongIncomingEdges ])
			ifFalse: [
				| aTreeNode |
				aTreeNode := GtGradTreeNode on: aNodeElement.
				visitedDictionary at: aNodeElement put: aTreeNode.
				self dfs: aTreeNode visited: visitedDictionary.
				separateSubtrees
					ifTrue: [ 
						"The easiest way of showing distinct subtrees consists of connecting new tree
						nodes as children of leaf nodes. This ensures the desired result without having
						to modify the algorithm. If the graph has cycles, its nodes might be a leaves even 
						though their element have outgoing edges."
						self addChildNodesToLeaves:	aTreeNode.
					].
				allTrees at: aTreeNode root put: #root ] ].

	^ self new trees: allTrees keys
]
