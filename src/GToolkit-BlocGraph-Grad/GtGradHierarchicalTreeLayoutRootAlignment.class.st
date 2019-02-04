Class {
	#name : #GtGradHierarchicalTreeLayoutRootAlignment,
	#superclass : #GtGradHierarchicalTreeLayoutAlignment,
	#category : #'GToolkit-BlocGraph-Grad-Layouts'
}

{ #category : #initialization }
GtGradHierarchicalTreeLayoutRootAlignment >> constructHierarchicalAlignment [
	^ GtGradHierarchicalLayoutRootAlignment new 
]

{ #category : #initialization }
GtGradHierarchicalTreeLayoutRootAlignment >> constructTreeAlignment [
	^ GtGradTreeNodesRootAlignment new 
]
