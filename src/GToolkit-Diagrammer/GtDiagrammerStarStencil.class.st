"
I create a star element
"
Class {
	#name : #GtDiagrammerStarStencil,
	#superclass : #GtDiagrammerElementStencil,
	#category : 'GToolkit-Diagrammer-Stencils - Figures'
}

{ #category : #'instance creation' }
GtDiagrammerStarStencil >> create [
	^ (BlPolygon vertices: ({
		50@0.
		65@40.
		100@40.
		75@60.
		85@100.
		50@80.
		15@100.
		25@60.
		0@40.
		35@40.
	} collect: [ :each | each * 2 ])) asElement
]
