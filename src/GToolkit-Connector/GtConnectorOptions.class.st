Class {
	#name : #GtConnectorOptions,
	#superclass : #Object,
	#instVars : [
		'drawLines'
	],
	#category : #'GToolkit-Connector-Core'
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
