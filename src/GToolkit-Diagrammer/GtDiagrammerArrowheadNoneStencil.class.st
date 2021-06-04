"
I am used to remove arrow heads


"
Class {
	#name : #GtDiagrammerArrowheadNoneStencil,
	#superclass : #GtDiagrammerArrowheadStencil,
	#category : #'GToolkit-Diagrammer-Stencils - Arrowheads'
}

{ #category : #hook }
GtDiagrammerArrowheadNoneStencil >> applyAsFromHeadOn: aCurveElement [
	aCurveElement removeFromHead
]

{ #category : #hook }
GtDiagrammerArrowheadNoneStencil >> applyAsToHeadOn: aCurveElement [
	aCurveElement removeToHead
]

{ #category : #'instance creation' }
GtDiagrammerArrowheadNoneStencil >> create [
	^ BlArrowheadNone new
]
