"
I create a filled circle arrow head with the border and background equal to the color of the curve
"
Class {
	#name : #GtDiagrammerArrowheadFilledCircleStencil,
	#superclass : #GtDiagrammerArrowheadCircleStencil,
	#category : 'GToolkit-Diagrammer-Stencils - Arrowheads'
}

{ #category : #comparing }
GtDiagrammerArrowheadFilledCircleStencil >> compareTo: anArrowheadElement [
	^ anArrowheadElement background isTransparent not
]

{ #category : #'instance creation' }
GtDiagrammerArrowheadFilledCircleStencil >> create [
	<return: #BlArrowheadCircle>

	^ BlArrowheadCircle new
		scale: self scale;
		border: (BlBorder paint: Color lightGray);
		background: Color lightGray;
		yourself
]

{ #category : #'instance creation' }
GtDiagrammerArrowheadFilledCircleStencil >> createFor: aCurveElement [
	<return: #BlArrowheadCircle>

	^ (super createFor: aCurveElement)
		background: (aCurveElement border paint copy)
]
