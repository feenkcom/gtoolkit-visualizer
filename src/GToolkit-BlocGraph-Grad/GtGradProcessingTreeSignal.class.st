Class {
	#name : #GtGradProcessingTreeSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'root'
	],
	#category : 'GToolkit-BlocGraph-Grad-Signals'
}

{ #category : #testing }
GtGradProcessingTreeSignal class >> gtNormalOperationSignal [
	^ true
]

{ #category : #accessing }
GtGradProcessingTreeSignal >> root [
	^ root
]

{ #category : #accessing }
GtGradProcessingTreeSignal >> root: anObject [
	root := anObject
]
