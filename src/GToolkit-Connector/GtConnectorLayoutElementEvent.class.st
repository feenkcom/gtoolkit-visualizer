Class {
	#name : #GtConnectorLayoutElementEvent,
	#superclass : #BlEvent,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-Connector-Events'
}

{ #category : #accessing }
GtConnectorLayoutElementEvent >> element [
	^ element
]

{ #category : #accessing }
GtConnectorLayoutElementEvent >> element: anObject [
	element := anObject
]
