"
I am the abstract root class of weighted circle layout. Look at the class comments of my subclasses for more details.


"
Class {
	#name : #GtGraphAbstractWeightedCircleLayout,
	#superclass : #GtGraphCircleLayout,
	#category : #'GToolkit-BlocGraph-Layouts-Layouts'
}

{ #category : #hook }
GtGraphAbstractWeightedCircleLayout >> doExecute: elements with: anExtentSpec [
	"This method is used polymorphically"
]

{ #category : #hook }
GtGraphAbstractWeightedCircleLayout >> weightSum: elements [
	"Computes the sum of all elements 'weight' or size"
	| sum |
	sum := 0.
	elements
		do: [ :each |
			sum := sum + (each height)
		].
	^sum
]
