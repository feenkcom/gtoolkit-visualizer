Class {
	#name : #GtGradDFSTreeForest,
	#superclass : #GtGradTreeForest,
	#instVars : [
		'trees'
	],
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'private - depth-first-search' }
GtGradDFSTreeForest class >> dfs: theCurrentNode visited: aVisitedDictionary [

	"aVisitedDictionary is a dictionary of already visited visual elements (element -> tree node)"
	aVisitedDictionary
		at: theCurrentNode element
		put: theCurrentNode.

	theCurrentNode element graph nodesAlongOutgoingEdges
		do: [ :aNodeElement |
			(aVisitedDictionary includesKey: aNodeElement)
				ifFalse: [
					| aTreeNode |
					aTreeNode := GtGradTreeNode on: aNodeElement.
					theCurrentNode add: aTreeNode.
					self
						dfs: aTreeNode
						visited: aVisitedDictionary ] ]
]

{ #category : #'instance-creation' }
GtGradDFSTreeForest class >> from: aCollectionOfElements [
	"Create a forest of node trees using depth-first-search algorithm"
	| allTrees visitedDictionary |

	allTrees := OrderedDictionary new.
	visitedDictionary := IdentityDictionary new.

	aCollectionOfElements do: [ :aNodeElement |
		((visitedDictionary includesKey: aNodeElement) or: [ aNodeElement graph hasNodesAlongIncomingEdges ])
			ifFalse: [
				| aTreeNode |
				aTreeNode := GtGradTreeNode on: aNodeElement.
				self dfs: aTreeNode visited: visitedDictionary.
				allTrees at: aTreeNode root put: #root ] ].

	^ self new trees: allTrees keys
]
