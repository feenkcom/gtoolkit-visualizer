Class {
	#name : #GtConnectorEventHandler,
	#superclass : #BlEventHandler,
	#instVars : [
		'id'
	],
	#category : #'GToolkit-Connector-Core'
}

{ #category : #accessing }
GtConnectorEventHandler >> id [
	^ id
]

{ #category : #accessing }
GtConnectorEventHandler >> id: anObject [
	id := anObject
]
