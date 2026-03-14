Class {
	#name : #GtConnectorLayoutSourceElementRemovedEvent,
	#superclass : #GtConnectorLayoutElementEvent,
	#category : #'GToolkit-Connector-Events'
}

{ #category : #sending }
GtConnectorLayoutSourceElementRemovedEvent >> sendTo: anObject [
	anObject layoutSourceRemoved: self
]
