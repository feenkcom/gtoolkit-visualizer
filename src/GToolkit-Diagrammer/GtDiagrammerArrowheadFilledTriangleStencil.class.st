"
I create a filled triangle arrowhead


"
Class {
	#name : #GtDiagrammerArrowheadFilledTriangleStencil,
	#superclass : #GtDiagrammerArrowheadTriangleStencil,
	#category : #'GToolkit-Diagrammer-Stencils - Arrowheads'
}

{ #category : #comparing }
GtDiagrammerArrowheadFilledTriangleStencil >> compareTo: anArrowheadElement [
	^ anArrowheadElement background isTransparent not
]

{ #category : #'instance creation' }
GtDiagrammerArrowheadFilledTriangleStencil >> create [
	^ BlArrowheadTriangle new
		scale: self scale;
		borderFraction: self borderFraction;
		border: (BlBorder paint: Color lightGray);
		background: Color lightGray;
		yourself
]

{ #category : #'instance creation' }
GtDiagrammerArrowheadFilledTriangleStencil >> createFor: aCurveElement [
	<return: #BlArrowheadElement>

	^ (super createFor: aCurveElement)
		background: (aCurveElement border paint copy)
]
