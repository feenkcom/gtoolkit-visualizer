Class {
	#name : #GtGradWestHierarchicalTreeLayout,
	#superclass : #GtGradHierarchicalTreeLayout,
	#category : #'GToolkit-BlocGraph-Grad-Layouts'
}

{ #category : #'private - layout' }
GtGradWestHierarchicalTreeLayout >> constructLayoutAlgorithm: anElementsCollection [
	(self isATreeOrHasLessThanMaxBackEdges: anElementsCollection)
		ifTrue: [ 
			| treeAlignment |
			treeAlignment := self alignment constructTreeAlignment.
			^ GtGradHorizontalDominanceTreeLayout new
												 levelDistance: self levelDistance;
												 nodeDistance: self nodesDistance;
												 treesDistance: self componentsDistance;
												 nodesAlignment: treeAlignment.
		]
		ifFalse: [ 
			| hierarchicalAlignment |
			hierarchicalAlignment := self alignment constructHierarchicalAlignment.
			^ GtGradWestHierarchicalLayout new
												 interRanksSpacing: self levelDistance;
												 intraRankSpacing: self nodesDistance;
												 interHierarchySpacing: self componentsDistance;
												 alignment: hierarchicalAlignment.
		].
]
