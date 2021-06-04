"
I create a hollow circle arrow head with the border equal to the color of the curve


"
Class {
	#name : #GtDiagrammerArrowheadHollowCircleStencil,
	#superclass : #GtDiagrammerArrowheadCircleStencil,
	#category : #'GToolkit-Diagrammer-Stencils - Arrowheads'
}

{ #category : #comparing }
GtDiagrammerArrowheadHollowCircleStencil >> compareTo: anArrowheadElement [
	^ anArrowheadElement background isTransparent
]

{ #category : #'instance creation' }
GtDiagrammerArrowheadHollowCircleStencil >> create [
	^ BlArrowheadCircle new
		scale: self scale;
		border: (BlBorder paint: Color lightGray);
		yourself
]

{ #category : #'instance creation' }
GtDiagrammerArrowheadHollowCircleStencil >> createFor: aCurveElement [
	<return: #BlArrowheadCircle>

	^ (super createFor: aCurveElement)
		background: (Color transparent)
]
