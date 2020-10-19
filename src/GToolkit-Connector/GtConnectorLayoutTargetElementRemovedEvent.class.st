Class {
	#name : #GtConnectorLayoutTargetElementRemovedEvent,
	#superclass : #GtConnectorLayoutElementEvent,
	#category : #'GToolkit-Connector-Events'
}

{ #category : #sending }
GtConnectorLayoutTargetElementRemovedEvent >> sendTo: anObject [
	anObject layoutTargetRemoved: self
]
