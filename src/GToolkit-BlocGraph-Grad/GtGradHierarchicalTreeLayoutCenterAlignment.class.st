Class {
	#name : #GtGradHierarchicalTreeLayoutCenterAlignment,
	#superclass : #GtGradHierarchicalTreeLayoutAlignment,
	#category : #'GToolkit-BlocGraph-Grad-Layouts'
}

{ #category : #initialization }
GtGradHierarchicalTreeLayoutCenterAlignment >> constructHierarchicalAlignment [
	^ GtGradHierarchicalLayoutCenterAlignment new 
]

{ #category : #initialization }
GtGradHierarchicalTreeLayoutCenterAlignment >> constructTreeAlignment [
	^ GtGradTreeNodesCenterAlignment new 
]
