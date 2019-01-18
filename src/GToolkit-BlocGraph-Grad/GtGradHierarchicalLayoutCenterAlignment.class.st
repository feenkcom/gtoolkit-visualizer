Class {
	#name : #GtGradHierarchicalLayoutCenterAlignment,
	#superclass : #GtGradHierarchicalLayoutAlignment,
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #calculating }
GtGradHierarchicalLayoutCenterAlignment >> calculateAlignment: aNode [
	^ aNode height / 2
]
