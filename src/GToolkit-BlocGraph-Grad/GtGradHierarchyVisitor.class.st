Class {
	#name : #GtGradHierarchyVisitor,
	#superclass : #Object,
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #visiting }
GtGradHierarchyVisitor >> visit: aNode parent: parent connectingEdge: connectingEdge layer: layer visited: visited [
	self subclassResponsibility
]
