Class {
	#name : #GtGradHierarchicalLayoutBottomAlignment,
	#superclass : #GtGradHierarchicalLayoutAlignment,
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #calculating }
GtGradHierarchicalLayoutBottomAlignment >> calculateAlignmentCorrection: aNode [
	| maxHeight |
	maxHeight := self maxNodeHeightPerRank at: (aNode minRank + 1).
	^  aNode height - (maxHeight / 2)
]
