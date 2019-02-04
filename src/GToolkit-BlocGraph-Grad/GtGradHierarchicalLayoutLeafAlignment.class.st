Class {
	#name : #GtGradHierarchicalLayoutLeafAlignment,
	#superclass : #GtGradHierarchicalLayoutAlignment,
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #calculating }
GtGradHierarchicalLayoutLeafAlignment >> calculateAlignmentCorrection: aNode [
	| maxHeight |
	maxHeight := self maxNodeHeightPerRank at: (aNode minRank + 1).
	^  aNode height - (maxHeight / 2)
]
