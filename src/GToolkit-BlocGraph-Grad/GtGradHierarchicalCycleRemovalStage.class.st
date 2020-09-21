Class {
	#name : #GtGradHierarchicalCycleRemovalStage,
	#superclass : #GtGradHierarchicalLayoutStage,
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #'layout - computations' }
GtGradHierarchicalCycleRemovalStage >> execute [
	| aVisitedNodesSet aVisitedNodesSetCopy aRootNodesCollection visitor newRootsCandidates |
	aVisitedNodesSet := Set new.
	aRootNodesCollection := self model rootNodes.
	visitor := GtGradHierarchyCycleRemovalVisitor new visitedNodes: aVisitedNodesSet.
	self model visit: visitor dfsRoots: aRootNodesCollection trackAncestors: true visitedNodes: aVisitedNodesSet.
	newRootsCandidates := Set new.
	aVisitedNodesSet size < (self model hierarchyNodesDictionary size)
		ifTrue: [
			newRootsCandidates := (self model hierarchyNodesDictionary values)
										 select: [ :aNode | (aVisitedNodesSet includes: aNode) not ].
		].

	aVisitedNodesSetCopy := aVisitedNodesSet copy.
	aRootNodesCollection removeAll.
	newRootsCandidates isNotEmpty
		ifTrue: [
			"Add a random one. For now, adding thefirst one"
			aRootNodesCollection add: newRootsCandidates first.
		].	
	self model visit: visitor dfsRoots: aRootNodesCollection trackAncestors: true visitedNodes: aVisitedNodesSetCopy.
	newRootsCandidates do: [ :aRootCandidate |
		| anElement |
		anElement := aRootCandidate element.
		anElement nodesAlongIncomingEdges isEmpty
			ifTrue: [ self model roots add: anElement].
	]	




]
