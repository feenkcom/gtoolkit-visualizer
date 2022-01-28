Class {
	#name : #GtGradDFSTreeForest,
	#superclass : #GtGradTreeForest,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'private - depth-first-search' }
GtGradDFSTreeForest class >> dfs: theCurrentNode visited: aVisitedDictionary [

	"aVisitedDictionary is a dictionary of already visited visual elements (element -> tree node)"

	aVisitedDictionary at: theCurrentNode element put: theCurrentNode.
	theCurrentNode element hasNodesAlongOutgoingEdges ifTrue: [ 
		theCurrentNode element nodesAlongOutgoingEdges do: [ :aNodeElement | 
			(aVisitedDictionary includesKey: aNodeElement) ifFalse: [ 
				| aTreeNode |
				aTreeNode := GtGradTreeNode on: aNodeElement.
				theCurrentNode add: aTreeNode.
				self dfs: aTreeNode visited: aVisitedDictionary ] ] ]
]
