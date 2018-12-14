Class {
	#name : #GtGradHierarchyCycleRemovalVisitor,
	#superclass : #GtGradHierarchyVisitor,
	#instVars : [
		'visitedNodes'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #visiting }
GtGradHierarchyCycleRemovalVisitor >> visit: aNode parent: parent connectingEdge: connectingEdge layer: layer visited: visited [
	Halt now.
	(aNode isAncestorOfNode: parent)
		ifTrue: [ 
			connectingEdge invert.
			parent outgoingEdges remove: connectingEdge.
			parent incomingEdges add: connectingEdge.
			aNode incomingEdges remove: connectingEdge.
			aNode outgoingEdges add: connectingEdge.
		].
		"TODO this is really ugly. This about refactoring"
		self visitedNodes add: aNode.
]

{ #category : #accessing }
GtGradHierarchyCycleRemovalVisitor >> visitedNodes [
	^ visitedNodes
]

{ #category : #accessing }
GtGradHierarchyCycleRemovalVisitor >> visitedNodes: anObject [
	visitedNodes := anObject
]
