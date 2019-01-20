Class {
	#name : #GtGradHierarchicalLayoutTopAlignment,
	#superclass : #GtGradHierarchicalLayoutAlignment,
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #calculating }
GtGradHierarchicalLayoutTopAlignment >> calculateAlignmentCorrection: aNode [
	^ (self maxNodeHeightPerRank at: (aNode minRank + 1)) / 2
]
