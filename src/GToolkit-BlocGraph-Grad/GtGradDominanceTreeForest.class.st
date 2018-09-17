Class {
	#name : #GtGradDominanceTreeForest,
	#superclass : #GtGradTreeForest,
	#instVars : [
		'trees'
	],
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'private - depth-first-search' }
GtGradDominanceTreeForest class >> dfs: theRootNode [
	|aVisitedDictionary |
	aVisitedDictionary := IdentityDictionary new.
	aVisitedDictionary := IdentityDictionary new.
	self dfs: theRootNode visited: aVisitedDictionary.
	
]

{ #category : #'private - depth-first-search' }
GtGradDominanceTreeForest class >> dfs: theCurrentNode visited: aVisitedDictionary [
	| currentDepth |
	currentDepth := theCurrentNode depth.
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
		] 
]

{ #category : #'instance-creation' }
GtGradDominanceTreeForest class >> from: aCollectionOfElements [
	"Create a forest of node trees using depth-first-search algorithm"
	| allTrees visitedDictionary  |

	allTrees := OrderedDictionary new.
	visitedDictionary := IdentityDictionary new.


	aCollectionOfElements do: [ :aNodeElement |
		((visitedDictionary includesKey: aNodeElement) or: [ aNodeElement graph hasNodesAlongIncomingEdges ])
			ifFalse: [
				| aTreeNode |
				aTreeNode := GtGradTreeNode on: aNodeElement.
				self dfs: aTreeNode.
				allTrees at: aTreeNode root put: #root ] ].

	^ self new trees: allTrees keys
]
