Class {
	#name : #GtGradKamadaKawaiInitialPositionSetSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'node',
		'position'
	],
	#category : #'GToolkit-BlocGraph-Grad-Signals'
}

{ #category : #accessing }
GtGradKamadaKawaiInitialPositionSetSignal >> node [
	^ node
]

{ #category : #accessing }
GtGradKamadaKawaiInitialPositionSetSignal >> node: anObject [
	node := anObject
]

{ #category : #accessing }
GtGradKamadaKawaiInitialPositionSetSignal >> position [
	^ position
]

{ #category : #accessing }
GtGradKamadaKawaiInitialPositionSetSignal >> position: anObject [
	position := anObject
]
