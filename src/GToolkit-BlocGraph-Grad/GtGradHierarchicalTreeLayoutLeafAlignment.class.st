Class {
	#name : #GtGradHierarchicalTreeLayoutLeafAlignment,
	#superclass : #GtGradHierarchicalTreeLayoutAlignment,
	#category : #'GToolkit-BlocGraph-Grad-Layouts'
}

{ #category : #initialization }
GtGradHierarchicalTreeLayoutLeafAlignment >> constructHierarchicalAlignment [
	^ GtGradHierarchicalLayoutLeafAlignment new 
]

{ #category : #initialization }
GtGradHierarchicalTreeLayoutLeafAlignment >> constructTreeAlignment [
	^ GtGradTreeNodesLeafAlignment new 
]
