"
1. Connector's entity event handler

Is added to each entity element in the connector


"
Class {
	#name : #GtConnectorEntityEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'connector'
	],
	#category : #'GToolkit-Connector-Events'
}

{ #category : #accessing }
GtConnectorEntityEventHandler >> connector [
	<return: #GtConnector>

	^ connector
]

{ #category : #accessing }
GtConnectorEntityEventHandler >> connector: aGtConnector [
	connector := aGtConnector
]

{ #category : #'api - accessing' }
GtConnectorEntityEventHandler >> eventsToHandle [
	^ {
		GtConnectorLayoutSourceElementRemovedEvent.
		GtConnectorLayoutTargetElementRemovedEvent.
		GtConnectorVisualSourceElementRemovedEvent.
		GtConnectorVisualTargetElementRemovedEvent.
	}
]

{ #category : #'event handling' }
GtConnectorEntityEventHandler >> layoutSourceRemoved: anEvent [
	self connector
		emitSignalForEvent: anEvent;
		removeEdgeConstraintsFrom: anEvent element;
		removeLinesFrom: anEvent element;
		requestLayout
]

{ #category : #'event handling' }
GtConnectorEntityEventHandler >> layoutTargetRemoved: anEvent [
	self connector
		emitSignalForEvent: anEvent;
		removeEdgeConstraintsTo: anEvent element;
		removeLinesTo: anEvent element;
		requestLayout
]

{ #category : #'event handling' }
GtConnectorEntityEventHandler >> visualSourceRemoved: anEvent [
	self connector
		emitSignalForEvent: anEvent;
		removeLinesFrom: anEvent element
]

{ #category : #'event handling' }
GtConnectorEntityEventHandler >> visualTargetRemoved: anEvent [
	self connector
		emitSignalForEvent: anEvent;
		removeLinesTo: anEvent element
]
