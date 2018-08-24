"
I am an abstract factory of objects that should appear in the diagrammer
"
Class {
	#name : #GtDiagrammerStencil,
	#superclass : #Object,
	#category : 'GToolkit-Diagrammer-Stencils'
}

{ #category : #'instance creation' }
GtDiagrammerStencil >> create [
	<return: #Object>

	^ self subclassResponsibility
]
