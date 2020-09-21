Class {
	#name : #GtGradDFSTreeForest,
	#superclass : #GtGradTreeForest,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'private - depth-first-search' }
GtGradDFSTreeForest class >> dfs: theCurrentNode visited: aVisitedDictionary [

	"aVisitedDictionary is a dictionary of already visited visual elements (element -> tree node)"
	aVisitedDictionary at: theCurrentNode element put: theCurrentNode.
	theCurrentNode element hasNodesAlongOutgoingEdges
		ifTrue: [ theCurrentNode element nodesAlongOutgoingEdges
				do: [ :aNodeElement | 
					(aVisitedDictionary includesKey: aNodeElement)
						ifFalse: [ | aTreeNode |
							aTreeNode := GtGradTreeNode on: aNodeElement.
							theCurrentNode add: aTreeNode.
							self dfs: aTreeNode visited: aVisitedDictionary ] ] ]
]

{ #category : #'instance-creation' }
GtGradDFSTreeForest class >> from: aCollectionOfLayoutNodesWithEdges separateSubtrees: separateSubtrees [
	"Create a forest of node trees using depth-first-search algorithm"

	| allTrees visitedDictionary |
	allTrees := OrderedDictionary new.
	visitedDictionary := IdentityDictionary new.
	aCollectionOfLayoutNodesWithEdges
		do: [ :eachLayoutNode | 
			((visitedDictionary includesKey: eachLayoutNode)
				or: [ eachLayoutNode hasNodesAlongIncomingEdges ])
				ifFalse: [ | aTreeNode |
					aTreeNode := GtGradTreeNode on: eachLayoutNode.
					self dfs: aTreeNode visited: visitedDictionary.
					allTrees at: aTreeNode root put: #root.
					separateSubtrees
						ifTrue: [ 
							"The easiest way of showing distinct subtrees consists of connecting new tree
							nodes as children of leaf nodes. This ensures the desired result without having
							to modify the algorithm. If the graph has cycles, its nodes might be a leaves 
							even though their element have outgoing edges."
							self addChildNodesToLeaves:	aTreeNode.
					].
					 ] ].
	^ self new trees: allTrees keys
]
