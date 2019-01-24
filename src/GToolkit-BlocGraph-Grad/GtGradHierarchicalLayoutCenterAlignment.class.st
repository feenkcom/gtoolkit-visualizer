Class {
	#name : #GtGradHierarchicalLayoutCenterAlignment,
	#superclass : #GtGradHierarchicalLayoutAlignment,
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #calculating }
GtGradHierarchicalLayoutCenterAlignment >> calculateAlignmentCorrection: aNode [
	^ aNode height / 2
]
