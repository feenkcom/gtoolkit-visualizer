Class {
	#name : #GtGradHierarchicalCycleRemovalStage,
	#superclass : #GtGradHierarchicalLayoutStage,
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #'layout - computations' }
GtGradHierarchicalCycleRemovalStage >> execute: parent [
	| aVisitedNodesSet aVisitedNodesSetCopy aRootNodesCollection visitor newRootsCandidates |
	aVisitedNodesSet := Set new.
	aRootNodesCollection := self model rootNodes.
	visitor := GtGradHierarchyCycleRemovalVisitor new visitedNodes: aVisitedNodesSet.
	self model visit: visitor dfsRoots: aRootNodesCollection trackAncestors: true visitedNodes: nil.
	newRootsCandidates := Set new.
	aVisitedNodesSet count < (self model hierarchyNodesDictionary count)
		ifTrue: [
			newRootsCandidates := (self model hierarchyNodesDictionary values)
										 select: [ :aNode | (aVisitedNodesSet includes: aNode) negated ].
		].

	aVisitedNodesSetCopy := Set new: aVisitedNodesSet.
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
		anElement graph nodesAlongIncomingEdgesCount = 0
			ifTrue: [ self model roots add: anElement].
	]	




]
