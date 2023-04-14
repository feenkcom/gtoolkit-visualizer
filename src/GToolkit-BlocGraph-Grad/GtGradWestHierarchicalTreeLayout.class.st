Class {
	#name : #GtGradWestHierarchicalTreeLayout,
	#superclass : #GtGradHierarchicalTreeLayout,
	#category : #'GToolkit-BlocGraph-Grad-Layouts'
}

{ #category : #'private - layout' }
GtGradWestHierarchicalTreeLayout >> hierarchicalLayoutClass [
	^ GtGradWestHierarchicalLayout
]

{ #category : #accessing }
GtGradWestHierarchicalTreeLayout >> reverseLayout [
	^false
]

{ #category : #'private - layout' }
GtGradWestHierarchicalTreeLayout >> treeLayoutClass [
	^ GtGradHorizontalDominanceTreeLayout
]
