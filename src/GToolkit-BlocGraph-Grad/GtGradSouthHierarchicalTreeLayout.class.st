Class {
	#name : #GtGradSouthHierarchicalTreeLayout,
	#superclass : #GtGradHierarchicalTreeLayout,
	#category : #'GToolkit-BlocGraph-Grad-Layouts'
}

{ #category : #'private - layout' }
GtGradSouthHierarchicalTreeLayout >> hierarchicalLayoutClass [
	^ GtGradSouthHierarchicalLayout
]

{ #category : #accessing }
GtGradSouthHierarchicalTreeLayout >> reverseLayout [
	^true
]

{ #category : #'private - layout' }
GtGradSouthHierarchicalTreeLayout >> treeLayoutClass [
	^ GtGradVerticalDominanceTreeLayout
]
