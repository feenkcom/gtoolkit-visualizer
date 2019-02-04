Class {
	#name : #GtGradHierarchicalLayoutRootAlignment,
	#superclass : #GtGradHierarchicalLayoutAlignment,
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #calculating }
GtGradHierarchicalLayoutRootAlignment >> calculateAlignmentCorrection: aNode [
	^ (self maxNodeHeightPerRank at: (aNode minRank + 1)) / 2
]
