"
I create an ellipse element


"
Class {
	#name : #GtDiagrammerEllipseStencil,
	#superclass : #GtDiagrammerElementStencil,
	#category : #'GToolkit-Diagrammer-Stencils - Figures'
}

{ #category : #'instance creation' }
GtDiagrammerEllipseStencil >> create [
	^ GtDiagrammerLabelledElement new
		geometry: BlEllipseGeometry new;
		size: 75@50
]
