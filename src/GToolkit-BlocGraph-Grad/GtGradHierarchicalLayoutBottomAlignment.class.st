Class {
	#name : #GtGradHierarchicalLayoutBottomAlignment,
	#superclass : #GtGradHierarchicalLayoutAlignment,
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #calculating }
GtGradHierarchicalLayoutBottomAlignment >> calculateAlignmentCorrection: aNode [
	^ aNode height - self  maxNodeHeightPerRank: (aNode minRank)
]
