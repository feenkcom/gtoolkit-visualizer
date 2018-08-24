"
I create an ellipse element
"
Class {
	#name : #GtDiagrammerEllipseStencil,
	#superclass : #GtDiagrammerElementStencil,
	#category : 'GToolkit-Diagrammer-Stencils - Figures'
}

{ #category : #'instance creation' }
GtDiagrammerEllipseStencil >> create [
	^ GtDiagrammerLabelledElement new
		geometry: BlEllipse new;
		size: 75@50
]
