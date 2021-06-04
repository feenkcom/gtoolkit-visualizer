"
A ROCircleLayout is xxxxxxxxx.


"
Class {
	#name : #GtGraphCircleLayout,
	#superclass : #GtGraphAbstractCircleLayout,
	#category : #'GToolkit-BlocGraph-Layouts-Layouts'
}

{ #category : #'instance creation' }
GtGraphCircleLayout class >> scaleBy: aNumber [
	
	^self new scaleBy: aNumber
]

{ #category : #hook }
GtGraphCircleLayout >> doExecute: elements with: anExtentSpec [
	| angleIncrement angle rad center |
	rad := self computeRadiusFor: elements.
	center := Point x: rad y: rad.
	angleIncrement := self computeIncrementalAngleFor: elements.
	angle := self initialAngle.
	elements
		do: [ :each | 
			| point |
			point := center + (Point gtR: rad theta: angle).
			angle := angle + angleIncrement.
			translator translateTopLeftOf: each to: point.
			self step ]
]
