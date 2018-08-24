"
Is sent by ButtonAttribute after button is created.

I allow Connector to be notified and attach its own additional handlers to newly created button
"
Class {
	#name : #GtConnectorButtonCreatedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'button'
	],
	#category : 'GToolkit-Connector-Events'
}

{ #category : #'instance creation' }
GtConnectorButtonCreatedEvent class >> button: anElement [
	^ self new button: anElement
]

{ #category : #accessing }
GtConnectorButtonCreatedEvent >> button [
	<return: #BlElement>

	^ button
]

{ #category : #accessing }
GtConnectorButtonCreatedEvent >> button: anElement [
	button := anElement
]
