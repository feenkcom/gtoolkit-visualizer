Class {
	#name : #GtConnectorVisualElementEvent,
	#superclass : #BlEvent,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-Connector-Events'
}

{ #category : #accessing }
GtConnectorVisualElementEvent >> element [
	^ element
]

{ #category : #accessing }
GtConnectorVisualElementEvent >> element: anObject [
	element := anObject
]
