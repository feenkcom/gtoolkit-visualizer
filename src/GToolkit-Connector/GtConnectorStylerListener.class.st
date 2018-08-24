"
I handle styler events, process them and communicate actions to the connector
"
Class {
	#name : #GtConnectorStylerListener,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'connector',
		'buttonCreatedListener',
		'buttonAddedListener'
	],
	#category : 'GToolkit-Connector'
}

{ #category : #'event handling' }
GtConnectorStylerListener >> attributeCreated: anEvent [
	anEvent attribute addEventHandler: buttonCreatedListener
]

{ #category : #accessing }
GtConnectorStylerListener >> connector [
	^ connector
]

{ #category : #accessing }
GtConnectorStylerListener >> connector: anObject [
	connector := anObject
]

{ #category : #accessing }
GtConnectorStylerListener >> eventClass [
	^ GtConnectorStylerEvent
]

{ #category : #events }
GtConnectorStylerListener >> handleEvent: anEvent [
	anEvent sendTo: self
]

{ #category : #initialization }
GtConnectorStylerListener >> initialize [
	super initialize.

	buttonAddedListener := BlEventHandler
		on: GtConnectorButtonAddedEvent
		do: [ :anEvent | self connector connect: anEvent currentTarget ].

	buttonCreatedListener := BlEventHandler
		on: GtConnectorButtonCreatedEvent
		do: [ :anEvent | anEvent button addEventHandler: buttonAddedListener ]
]

{ #category : #'event handling' }
GtConnectorStylerListener >> linkCreated: anEvent [
	self connector addLink: anEvent link
]

{ #category : #'event handling' }
GtConnectorStylerListener >> linkDeleted: anEvent [
	self connector removeLink: anEvent link
]

{ #category : #events }
GtConnectorStylerListener >> wantsEvent: anEvent [
	^ anEvent class == self eventClass
		or: [ anEvent class inheritsFrom: self eventClass ]
]
