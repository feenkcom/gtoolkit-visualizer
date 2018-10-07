Class {
	#name : #GtGradDFSTreeForest,
	#superclass : #GtGradTreeForest,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'private - depth-first-search' }
GtGradDFSTreeForest class >> dfs: theCurrentNode visited: aVisitedDictionary separateSubtrees: separateSubtrees [
	|elementSize|
	elementSize := theCurrentNode element measuredBounds extent.

	"aVisitedDictionary is a dictionary of already visited visual elements (element -> tree node)"
	aVisitedDictionary
		at: theCurrentNode element
		put: theCurrentNode.

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
				(aVisitedDictionary includesKey: aNodeElement)
					ifFalse: [
						| aTreeNode |
						aTreeNode := GtGradTreeNode on: aNodeElement.
						theCurrentNode add: aTreeNode.
						self
							dfs: aTreeNode
							visited: aVisitedDictionary
							separateSubtrees: separateSubtrees
							]
					]
			]
]

{ #category : #'instance-creation' }
GtGradDFSTreeForest class >> from: aCollectionOfElements separateSubtrees: separateSubtrees [
	"Create a forest of node trees using depth-first-search algorithm"
	| allTrees visitedDictionary |

	allTrees := OrderedDictionary new.
	visitedDictionary := IdentityDictionary new.

	aCollectionOfElements do: [ :aNodeElement |
		((visitedDictionary includesKey: aNodeElement) or: [ aNodeElement graph hasNodesAlongIncomingEdges ])
			ifFalse: [
				| aTreeNode |
				aTreeNode := GtGradTreeNode on: aNodeElement.
				self dfs: aTreeNode visited: visitedDictionary separateSubtrees: separateSubtrees.
				allTrees at: aTreeNode root put: #root ] ].

	^ self new trees: allTrees keys
]
