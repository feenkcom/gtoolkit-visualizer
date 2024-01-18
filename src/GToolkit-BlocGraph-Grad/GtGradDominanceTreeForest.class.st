Class {
	#name : #GtGradDominanceTreeForest,
	#superclass : #GtGradTreeForest,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'private - depth-first-search' }
GtGradDominanceTreeForest class >> dfs: theCurrentNode visited: aVisitedDictionary [
	| currentDepth |
	currentDepth := theCurrentNode depth.
	theCurrentNode element nodesAlongOutgoingEdges
		do: [ :aNodeElement | 
			| aTreeNode |
			(aVisitedDictionary includesKey: aNodeElement)
				ifTrue: [ | oldDepth |
					aTreeNode := aVisitedDictionary at: aNodeElement.
					oldDepth := aTreeNode parent depth.
					((theCurrentNode allParents includes: aTreeNode) not
						and: [ currentDepth > oldDepth ])
						ifTrue: [ aTreeNode parent remove: aTreeNode.
							theCurrentNode add: aTreeNode ] ]
				ifFalse: [ aTreeNode := GtGradTreeNode on: aNodeElement.
					theCurrentNode add: aTreeNode.
					aVisitedDictionary at: aNodeElement put: aTreeNode.
					self dfs: aTreeNode visited: aVisitedDictionary ] ]
]
