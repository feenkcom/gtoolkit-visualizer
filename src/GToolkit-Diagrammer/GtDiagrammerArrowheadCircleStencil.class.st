Class {
	#name : #GtDiagrammerArrowheadCircleStencil,
	#superclass : #GtDiagrammerArrowheadStencil,
	#instVars : [
		'scale'
	],
	#category : 'GToolkit-Diagrammer-Stencils - Arrowheads'
}

{ #category : #'instance creation' }
GtDiagrammerArrowheadCircleStencil >> create [
	<return: #BlArrowheadCircle>

	^ self subclassResponsibility
]

{ #category : #initialization }
GtDiagrammerArrowheadCircleStencil >> initialize [
	super initialize.
	
	scale := 5
]

{ #category : #'instance creation' }
GtDiagrammerArrowheadCircleStencil >> preview [
	^ self create scale: 3
]

{ #category : #accessing }
GtDiagrammerArrowheadCircleStencil >> scale [
	^ scale
]

{ #category : #accessing }
GtDiagrammerArrowheadCircleStencil >> scale: aNumber [
	scale := aNumber
]
