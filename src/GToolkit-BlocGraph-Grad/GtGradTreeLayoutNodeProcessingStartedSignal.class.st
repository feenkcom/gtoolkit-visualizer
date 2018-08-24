Class {
	#name : #GtGradTreeLayoutNodeProcessingStartedSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'node'
	],
	#category : 'GToolkit-BlocGraph-Grad-Signals'
}

{ #category : #accessing }
GtGradTreeLayoutNodeProcessingStartedSignal >> node [
	^ node
]

{ #category : #accessing }
GtGradTreeLayoutNodeProcessingStartedSignal >> node: aTreeNode [
	node := aTreeNode
]
