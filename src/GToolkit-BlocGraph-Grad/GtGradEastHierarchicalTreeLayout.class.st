Class {
	#name : #GtGradEastHierarchicalTreeLayout,
	#superclass : #GtGradHierarchicalTreeLayout,
	#category : #'GToolkit-BlocGraph-Grad-Layouts'
}

{ #category : #'private - layout' }
GtGradEastHierarchicalTreeLayout >> hierarchicalLayoutClass [
	^ GtGradEastHierarchicalLayout
]

{ #category : #accessing }
GtGradEastHierarchicalTreeLayout >> reverseLayout [
	^true
]

{ #category : #'private - layout' }
GtGradEastHierarchicalTreeLayout >> treeLayoutClass [
	^ GtGradHorizontalDominanceTreeLayout
]
