"
I am a special stencil designed to create visual elements for a figure creation tool


"
Class {
	#name : #GtDiagrammerElementStencil,
	#superclass : #GtDiagrammerStencil,
	#category : #'GToolkit-Diagrammer-Stencils - Figures'
}

{ #category : #'instance creation' }
GtDiagrammerElementStencil >> create [
	<return: #BlElement>

	^ self subclassResponsibility
]
