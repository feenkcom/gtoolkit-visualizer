Class {
	#name : #GtConnectorTargetElement,
	#superclass : #BlEvent,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-Connector'
}

{ #category : #accessing }
GtConnectorTargetElement >> element [
	^ element
]

{ #category : #accessing }
GtConnectorTargetElement >> element: anObject [
	element := anObject
]
