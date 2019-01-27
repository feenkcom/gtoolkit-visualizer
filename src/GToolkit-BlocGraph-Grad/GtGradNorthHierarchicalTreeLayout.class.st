Class {
	#name : #GtGradNorthHierarchicalTreeLayout,
	#superclass : #GtGradHierarchicalTreeLayout,
	#category : #'GToolkit-BlocGraph-Grad-Layouts'
}

{ #category : #'private - layout' }
GtGradNorthHierarchicalTreeLayout >> constructLayoutAlgorithm: anElementsCollection [
	(self isATreeOrHasLessThanMaxBackEdges: anElementsCollection)
		ifTrue: [ 
			| treeAlignment |
			treeAlignment := self alignment constructTreeAlignment.
			^ GtGradVerticalDominanceTreeLayout new
												 levelDistance: self levelDistance;
												 nodeDistance: self nodesDistance;
												 treesDistance: self componentsDistance;
												 nodesAlignment: treeAlignment.
		]
		ifFalse: [ 
			| hierarchicalAlignment |
			hierarchicalAlignment := self alignment constructHierarchicalAlignment.
			^ GtGradNorthHierarchicalLayout new
												 interRanksSpacing: self levelDistance;
												 intraRankSpacing: self nodesDistance;
												 interHierarchySpacing: self componentsDistance;
												 alignment: hierarchicalAlignment.
		].
]
