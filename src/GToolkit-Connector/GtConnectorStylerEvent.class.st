"
I am an event sent by styler
"
Class {
	#name : #GtConnectorStylerEvent,
	#superclass : #BlEvent,
	#category : 'GToolkit-Connector-Events'
}

{ #category : #sending }
GtConnectorStylerEvent >> sendTo: anObject [
	self subclassResponsibility
]
