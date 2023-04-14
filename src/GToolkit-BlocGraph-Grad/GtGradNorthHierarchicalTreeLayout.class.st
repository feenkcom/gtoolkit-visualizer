Class {
	#name : #GtGradNorthHierarchicalTreeLayout,
	#superclass : #GtGradHierarchicalTreeLayout,
	#category : #'GToolkit-BlocGraph-Grad-Layouts'
}

{ #category : #'private - layout' }
GtGradNorthHierarchicalTreeLayout >> hierarchicalLayoutClass [
	^ GtGradNorthHierarchicalLayout
]

{ #category : #accessing }
GtGradNorthHierarchicalTreeLayout >> reverseLayout [
	^false
]

{ #category : #'private - layout' }
GtGradNorthHierarchicalTreeLayout >> treeLayoutClass [
	^ GtGradVerticalDominanceTreeLayout
]
