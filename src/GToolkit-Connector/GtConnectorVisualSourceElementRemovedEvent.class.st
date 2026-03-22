Class {
	#name : #GtConnectorVisualSourceElementRemovedEvent,
	#superclass : #GtConnectorVisualElementEvent,
	#category : #'GToolkit-Connector-Events'
}

{ #category : #sending }
GtConnectorVisualSourceElementRemovedEvent >> sendTo: anObject [
	anObject visualSourceRemoved: self
]
