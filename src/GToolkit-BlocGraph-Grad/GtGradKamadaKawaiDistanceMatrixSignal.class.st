Class {
	#name : #GtGradKamadaKawaiDistanceMatrixSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'distanceMatrix'
	],
	#category : #'GToolkit-BlocGraph-Grad-Signals'
}

{ #category : #accessing }
GtGradKamadaKawaiDistanceMatrixSignal >> distanceMatrix [
	^ distanceMatrix
]

{ #category : #accessing }
GtGradKamadaKawaiDistanceMatrixSignal >> distanceMatrix: anObject [
	distanceMatrix := anObject
]
