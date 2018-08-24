"
I am sent by styler when it creates a button attribute
"
Class {
	#name : #GtConnectorButtonAttributeCreatedEvent,
	#superclass : #GtConnectorStylerEvent,
	#instVars : [
		'attribute'
	],
	#category : 'GToolkit-Connector-Events'
}

{ #category : #accessing }
GtConnectorButtonAttributeCreatedEvent >> attribute [
	^ attribute
]

{ #category : #accessing }
GtConnectorButtonAttributeCreatedEvent >> attribute: anObject [
	attribute := anObject
]

{ #category : #sending }
GtConnectorButtonAttributeCreatedEvent >> sendTo: anObject [
	anObject attributeCreated: self
]
