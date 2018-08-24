"
I create a hollow triangle arrowhead
"
Class {
	#name : #GtDiagrammerArrowheadHollowTriangleStencil,
	#superclass : #GtDiagrammerArrowheadTriangleStencil,
	#category : 'GToolkit-Diagrammer-Stencils - Arrowheads'
}

{ #category : #comparing }
GtDiagrammerArrowheadHollowTriangleStencil >> compareTo: anArrowheadElement [
	^ anArrowheadElement background isTransparent
]

{ #category : #'instance creation' }
GtDiagrammerArrowheadHollowTriangleStencil >> create [
	^ BlArrowheadTriangle new
		scale: self scale;
		borderFraction: self borderFraction;
		border: (BlBorder paint: Color lightGray);
		background: Color transparent;
		yourself
]
