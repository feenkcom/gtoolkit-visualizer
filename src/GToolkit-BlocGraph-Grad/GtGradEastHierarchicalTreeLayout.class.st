Class {
	#name : #GtGradEastHierarchicalTreeLayout,
	#superclass : #GtGradHierarchicalTreeLayout,
	#category : #'GToolkit-BlocGraph-Grad-Layouts'
}

{ #category : #'private - layout' }
GtGradEastHierarchicalTreeLayout >> constructLayoutAlgorithm: anElementsCollection [
	(self isATreeOrHasLessThanMaxBackEdges: anElementsCollection)
		ifTrue: [ 
			| treeAlignment |
			treeAlignment := self alignment constructTreeAlignment.
			^ GtGradHorizontalDominanceTreeLayout new
												 levelDistance: self levelDistance;
												 nodeDistance: self nodesDistance;
												 treesDistance: self componentsDistance;
												 reverse: true;
												 nodesAlignment: treeAlignment.
		]
		ifFalse: [ 
			| hierarchicalAlignmetn |
			hierarchicalAlignmetn := self alignment constructHierarchicalAlignment.
			^ GtGradEastHierarchicalLayout new
												 interRanksSpacing: self levelDistance;
												 intraRankSpacing: self nodesDistance;
												 interHierarchySpacing: self componentsDistance;
												 alignment: hierarchicalAlignmetn.
		].
]
