"
I create a UML note  element
"
Class {
	#name : #GtDiagrammerUmlNoteStencil,
	#superclass : #GtDiagrammerElementStencil,
	#category : 'GToolkit-Diagrammer-Stencils - Figures'
}

{ #category : #'instance creation' }
GtDiagrammerUmlNoteStencil >> create [
	^ GtDiagrammerLabelledElement new
		geometry: (BlPolygon vertices: ({
		0@0.
		90@0.
		100@10.
		90@10.
		90@0.
		100@10.
		100@50.
		0@50
	} collect: [ :each | each ]));
	size: 100@50
]
