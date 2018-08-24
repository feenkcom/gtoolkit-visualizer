Class {
	#name : #GtGradTreeLayoutOffsetSetSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'node',
		'offsetX',
		'offsetY'
	],
	#category : 'GToolkit-BlocGraph-Grad-Signals'
}

{ #category : #accessing }
GtGradTreeLayoutOffsetSetSignal >> node [
	^ node
]

{ #category : #accessing }
GtGradTreeLayoutOffsetSetSignal >> node: anObject [
	node := anObject
]

{ #category : #accessing }
GtGradTreeLayoutOffsetSetSignal >> offsetX [
	^ offsetX
]

{ #category : #accessing }
GtGradTreeLayoutOffsetSetSignal >> offsetX: anObject [
	offsetX := anObject
]

{ #category : #accessing }
GtGradTreeLayoutOffsetSetSignal >> offsetY [
	^ offsetY
]

{ #category : #accessing }
GtGradTreeLayoutOffsetSetSignal >> offsetY: anObject [
	offsetY := anObject
]
