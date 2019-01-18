Class {
	#name : #GtGradHierarchicalLayoutBottomAlignment,
	#superclass : #GtGradHierarchicalLayoutAlignment,
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #calculating }
GtGradHierarchicalLayoutBottomAlignment >> calculateAlignment: aNode [
	^ aNode height - aNode maxRankHeight
]
