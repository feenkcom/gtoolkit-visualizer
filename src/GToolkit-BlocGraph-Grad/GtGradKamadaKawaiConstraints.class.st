Class {
	#name : #GtGradKamadaKawaiConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'computedPosition'
	],
	#category : 'GToolkit-BlocGraph-Grad-Force-Directed'
}

{ #category : #accessing }
GtGradKamadaKawaiConstraints >> computedPosition [
	^ computedPosition
]

{ #category : #accessing }
GtGradKamadaKawaiConstraints >> computedPosition: anObject [
	computedPosition := anObject
]

{ #category : #initialization }
GtGradKamadaKawaiConstraints >> initialize [
	super initialize.

	computedPosition := 0@0.

]
