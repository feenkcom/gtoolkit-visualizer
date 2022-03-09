Class {
	#name : #GtGradTreeLayoutNodeProcessingFinishedSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'node'
	],
	#category : 'GToolkit-BlocGraph-Grad-Signals'
}

{ #category : #testing }
GtGradTreeLayoutNodeProcessingFinishedSignal class >> gtNormalOperationSignal [
	^ true
]

{ #category : #accessing }
GtGradTreeLayoutNodeProcessingFinishedSignal >> node [
	^ node
]

{ #category : #accessing }
GtGradTreeLayoutNodeProcessingFinishedSignal >> node: aTreeNode [
	node := aTreeNode
]
