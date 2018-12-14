Class {
	#name : #GtGradHierarchicalCycleRemovalStage,
	#superclass : #GtGradHierarchicalLayoutStage,
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #'layout - computations' }
GtGradHierarchicalCycleRemovalStage >> execute [
	| aVisitedNodesCollection aVisitedNodesCollectionCopy aRootNodesCollection visitor newRootsCandidates |
	aVisitedNodesCollection := OrderedCollection new.
	aRootNodesCollection := self model rootNodes.
	visitor := GtGradHierarchyCycleRemovalVisitor new visitedNodes: aVisitedNodesCollection.
	self model visit: visitor dfsRoots: aRootNodesCollection trackAncestors: true visitedNodes: aVisitedNodesCollection.
	newRootsCandidates := Set new.
	aVisitedNodesCollection count < (self model hierarchyNodesDictionary count)
		ifTrue: [
			newRootsCandidates := (self model hierarchyNodesDictionary values)
										 select: [ :aNode | (aVisitedNodesCollection includes: aNode) negated ].
		].

	aVisitedNodesCollectionCopy := Collection new: aVisitedNodesCollection.
	aRootNodesCollection removeAll.
	newRootsCandidates isNotEmpty
		ifTrue: [
			"Add a random one. For now, adding thefirst one"
			aRootNodesCollection add: newRootsCandidates first.
		].	
	self model visit: visitor dfsRoots: aRootNodesCollection trackAncestors: true visitedNodes: aVisitedNodesCollectionCopy.
	newRootsCandidates do: [ :aRootCandidate |
		| anElement |
		anElement := aRootCandidate element.
		anElement graph nodesAlongIncomingEdgesCount = 0
			ifTrue: [ self model roots add: anElement].
	]	




]
