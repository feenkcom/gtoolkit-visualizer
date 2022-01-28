Class {
	#name : #GtGradDominanceTreeForest,
	#superclass : #GtGradTreeForest,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'private - depth-first-search' }
GtGradDominanceTreeForest class >> dfs: theCurrentNode visited: aVisitedDictionary [

	| currentDepth |
	currentDepth := theCurrentNode depth.
	theCurrentNode element hasNodesAlongOutgoingEdges ifTrue: [ 
		theCurrentNode element nodesAlongOutgoingEdges do: [ :aNodeElement | 
			| aTreeNode |
			(aVisitedDictionary includesKey: aNodeElement)
				ifTrue: [ 
					| oldDepth |
					aTreeNode := aVisitedDictionary at: aNodeElement.
					oldDepth := aTreeNode parent depth.
					(currentDepth > oldDepth and: [ 
						 aTreeNode parent depth > 0 or: [ 
							 aTreeNode parent nodes size > 1 ] ]) ifTrue: [ 
						aTreeNode parent remove: aTreeNode.
						theCurrentNode add: aTreeNode.
						self dfs: aTreeNode visited: aVisitedDictionary ] ]
				ifFalse: [ 
					aTreeNode := GtGradTreeNode on: aNodeElement.
					theCurrentNode add: aTreeNode.
					aVisitedDictionary at: aNodeElement put: aTreeNode.
					self dfs: aTreeNode visited: aVisitedDictionary ] ] ]
]
