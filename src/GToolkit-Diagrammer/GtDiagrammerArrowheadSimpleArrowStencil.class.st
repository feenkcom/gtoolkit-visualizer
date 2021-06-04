"
I create a ""simple arrow"" arrowhead


"
Class {
	#name : #GtDiagrammerArrowheadSimpleArrowStencil,
	#superclass : #GtDiagrammerArrowheadStencil,
	#instVars : [
		'arrowLengthFraction',
		'arrowNoseAngle'
	],
	#category : #'GToolkit-Diagrammer-Stencils - Arrowheads'
}

{ #category : #accessing }
GtDiagrammerArrowheadSimpleArrowStencil >> arrowLengthFraction [
	<return: #Number>

	^ arrowLengthFraction
]

{ #category : #accessing }
GtDiagrammerArrowheadSimpleArrowStencil >> arrowLengthFraction: aNumber [
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Length must not be nil' ].

	self
		assert: [ aNumber >= 0 ]
		description: [ 'Arrow length must not be negative' ].

	arrowLengthFraction := aNumber
]

{ #category : #accessing }
GtDiagrammerArrowheadSimpleArrowStencil >> arrowNoseAngle [
	^ arrowNoseAngle
]

{ #category : #accessing }
GtDiagrammerArrowheadSimpleArrowStencil >> arrowNoseAngle: aNumber [
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Length must not be nil' ].

	self
		assert: [ aNumber > 0 and: [ aNumber < 180 ] ]
		description: [ 'Arrow length must be within an open interval (0..180)' ].
		
	arrowNoseAngle := aNumber
]

{ #category : #'instance creation' }
GtDiagrammerArrowheadSimpleArrowStencil >> create [
	^ BlArrowheadSimpleArrow new
		arrowLengthFraction: self arrowLengthFraction;
		arrowNoseAngle: self arrowNoseAngle;
		background: Color lightGray;
		border: (BlBorder paint: Color lightGray);
		yourself
]

{ #category : #initialization }
GtDiagrammerArrowheadSimpleArrowStencil >> initialize [
	super initialize.

	arrowLengthFraction := 12.
	arrowNoseAngle := 45
]

{ #category : #'instance creation' }
GtDiagrammerArrowheadSimpleArrowStencil >> preview [
	^ self create
		arrowLengthFraction: 5
]
