Class {
	#name : #GtConnectorVisualSourceElementAddedEvent,
	#superclass : #GtConnectorVisualElementEvent,
	#category : #'GToolkit-Connector-Events'
}

{ #category : #sending }
GtConnectorVisualSourceElementAddedEvent >> sendTo: anObject [
	anObject visualSourceAdded: self
]
