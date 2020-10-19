Class {
	#name : #GtConnectorVisualTargetElementRemovedEvent,
	#superclass : #GtConnectorVisualElementEvent,
	#category : #'GToolkit-Connector-Events'
}

{ #category : #sending }
GtConnectorVisualTargetElementRemovedEvent >> sendTo: anObject [
	anObject visualTargetRemoved: self
]
