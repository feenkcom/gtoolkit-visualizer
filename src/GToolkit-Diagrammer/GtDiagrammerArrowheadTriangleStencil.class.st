Class {
	#name : #GtDiagrammerArrowheadTriangleStencil,
	#superclass : #GtDiagrammerArrowheadStencil,
	#instVars : [
		'scale',
		'borderFraction'
	],
	#category : 'GToolkit-Diagrammer-Stencils - Arrowheads'
}

{ #category : #accessing }
GtDiagrammerArrowheadTriangleStencil >> borderFraction [
	<return: #Number>

	^ borderFraction
]

{ #category : #accessing }
GtDiagrammerArrowheadTriangleStencil >> borderFraction: aNumber [
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Border fraction must not be nil' ].

	self
		assert: [ aNumber >= 0 ]
		description: [ 'Border fraction must not be negative' ].

	borderFraction := aNumber
]

{ #category : #'instance creation' }
GtDiagrammerArrowheadTriangleStencil >> create [
	<return: #BlArrowheadTriangle>
	
	^ self subclassResponsibility
]

{ #category : #initialization }
GtDiagrammerArrowheadTriangleStencil >> initialize [
	super initialize.
	
	scale := 6.
	borderFraction := 1
]

{ #category : #'instance creation' }
GtDiagrammerArrowheadTriangleStencil >> preview [
	^ self create
		scale: 1.8;
		borderFraction: 0.6
]

{ #category : #accessing }
GtDiagrammerArrowheadTriangleStencil >> scale [
	<return: #Number>

	^ scale
]

{ #category : #accessing }
GtDiagrammerArrowheadTriangleStencil >> scale: aNumber [
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Scale must not be nil' ].

	self
		assert: [ aNumber >= 0 ]
		description: [ 'Scale must not be negative' ].
		
	scale := aNumber
]
