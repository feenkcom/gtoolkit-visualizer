Class {
	#name : #GtGradKamadaKawaiLayoutDeltasSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'deltaAtNode'
	],
	#category : #'GToolkit-BlocGraph-Grad-Signals'
}

{ #category : #accessing }
GtGradKamadaKawaiLayoutDeltasSignal >> deltaAtNode [
	^ deltaAtNode
]

{ #category : #accessing }
GtGradKamadaKawaiLayoutDeltasSignal >> deltaAtNode: anObject [
	deltaAtNode := anObject
]
