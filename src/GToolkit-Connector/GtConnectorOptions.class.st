Class {
	#name : #GtConnectorOptions,
	#superclass : #Object,
	#instVars : [
		'drawLines'
	],
	#category : #'GToolkit-Connector'
}

{ #category : #accessing }
GtConnectorOptions >> drawLines [
	^ drawLines
]

{ #category : #accessing }
GtConnectorOptions >> drawLines: anObject [
	drawLines := anObject
]

{ #category : #accessing }
GtConnectorOptions >> initialize [
	drawLines := true.
]
