Class {
	#name : #GtGradTreeLayoutNodeProcessingFinishedSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'node'
	],
	#category : 'GToolkit-BlocGraph-Grad-Signals'
}

{ #category : #accessing }
GtGradTreeLayoutNodeProcessingFinishedSignal >> node [
	^ node
]

{ #category : #accessing }
GtGradTreeLayoutNodeProcessingFinishedSignal >> node: aTreeNode [
	node := aTreeNode
]
