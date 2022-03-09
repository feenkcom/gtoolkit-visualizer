Class {
	#name : #GtGradTreeLayoutCorrectionSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'node',
		'alignmentCorrection'
	],
	#category : 'GToolkit-BlocGraph-Grad-Signals'
}

{ #category : #testing }
GtGradTreeLayoutCorrectionSignal class >> gtNormalOperationSignal [
	^ true
]

{ #category : #accessing }
GtGradTreeLayoutCorrectionSignal >> alignmentCorrection [
	^ alignmentCorrection
]

{ #category : #accessing }
GtGradTreeLayoutCorrectionSignal >> alignmentCorrection: anObject [
	alignmentCorrection := anObject
]

{ #category : #accessing }
GtGradTreeLayoutCorrectionSignal >> node [
	^ node
]

{ #category : #accessing }
GtGradTreeLayoutCorrectionSignal >> node: anObject [
	node := anObject
]
