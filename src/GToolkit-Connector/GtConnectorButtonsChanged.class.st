Class {
	#name : #GtConnectorButtonsChanged,
	#superclass : #BlEvent,
	#instVars : [
		'newButtons',
		'oldButtons'
	],
	#category : 'GToolkit-Connector'
}

{ #category : #accessing }
GtConnectorButtonsChanged >> newButtons [
	^ newButtons
]

{ #category : #accessing }
GtConnectorButtonsChanged >> newButtons: anObject [
	newButtons := anObject
]

{ #category : #accessing }
GtConnectorButtonsChanged >> oldButtons [
	^ oldButtons
]

{ #category : #accessing }
GtConnectorButtonsChanged >> oldButtons: anObject [
	oldButtons := anObject
]
