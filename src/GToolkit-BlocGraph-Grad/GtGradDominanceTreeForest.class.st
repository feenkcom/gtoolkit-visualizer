Class {
	#name : #GtGradDominanceTreeForest,
	#superclass : #GtGradTreeForest,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'private - depth-first-search' }
GtGradDominanceTreeForest class >> dfs: theRootNode separateSubtrees: separateSubtrees [
	|aVisitedDictionary |
	aVisitedDictionary := IdentityDictionary new.
	aVisitedDictionary := IdentityDictionary new.
	self dfs: theRootNode visited: aVisitedDictionary separateSubtrees: separateSubtrees.
	
]

{ #category : #'private - depth-first-search' }
GtGradDominanceTreeForest class >> dfs: theCurrentNode visited: aVisitedDictionary separateSubtrees: separateSubtrees [
	| currentDepth |
	currentDepth := theCurrentNode depth.
		theCurrentNode element graph hasNodesAlongOutgoingEdges
		ifFalse: [
			"The easiest way of showing distinct subtrees consists of connecting new tree
			nodes as children of leaf nodes. This ensures the desired result without having
			to modify the algorithm"
			separateSubtrees
				ifTrue: [ 
					| aTreeNode |

					aTreeNode := GtGradTreeNode on: theCurrentNode element.
					theCurrentNode add: aTreeNode.
				] 
		]
		ifTrue: [ 
			theCurrentNode element graph nodesAlongOutgoingEdges
				do: [ :aNodeElement |
					| aTreeNode |
					(aVisitedDictionary includesKey: aNodeElement)
						ifTrue: [
							| oldDepth |
							aTreeNode := aVisitedDictionary at: aNodeElement.
							oldDepth := aTreeNode parent depth.
							currentDepth > oldDepth
								ifTrue: [ 
									aTreeNode parent remove: aTreeNode.
									theCurrentNode add: aTreeNode.
								]]
						ifFalse: [ 
							aTreeNode := GtGradTreeNode on: aNodeElement.
							theCurrentNode add: aTreeNode.
							aVisitedDictionary at: aNodeElement put: aTreeNode.
						].		
						self
							dfs: aTreeNode
							visited: aVisitedDictionary
							separateSubtrees: separateSubtrees
				] 
			]
]

{ #category : #'instance-creation' }
GtGradDominanceTreeForest class >> from: aCollectionOfElements separateSubtrees: separateSubtrees [
	"Create a forest of node trees using depth-first-search algorithm"
	| allTrees visitedDictionary  |

	allTrees := OrderedDictionary new.
	visitedDictionary := IdentityDictionary new.


	aCollectionOfElements do: [ :aNodeElement |
		((visitedDictionary includesKey: aNodeElement) or: [ aNodeElement graph hasNodesAlongIncomingEdges ])
			ifFalse: [
				| aTreeNode |
				aTreeNode := GtGradTreeNode on: aNodeElement.
				self dfs: aTreeNode separateSubtrees: separateSubtrees.
				allTrees at: aTreeNode root put: #root ] ].

	^ self new trees: allTrees keys
]
