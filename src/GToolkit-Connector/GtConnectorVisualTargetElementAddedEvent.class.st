Class {
	#name : #GtConnectorVisualTargetElementAddedEvent,
	#superclass : #GtConnectorVisualElementEvent,
	#category : #'GToolkit-Connector-Events'
}

{ #category : #sending }
GtConnectorVisualTargetElementAddedEvent >> sendTo: anObject [
	anObject visualTargetAdded: self
]
