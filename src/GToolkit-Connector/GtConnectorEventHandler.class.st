"
1. Connector event handler

Is added to the connector itself


"
Class {
	#name : #GtConnectorEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'connector'
	],
	#category : #'GToolkit-Connector-Events'
}

{ #category : #accessing }
GtConnectorEventHandler >> connector [
	<return: #GtConnector>

	^ connector
]

{ #category : #accessing }
GtConnectorEventHandler >> connector: aGtConnector [
	connector := aGtConnector
]

{ #category : #'api - accessing' }
GtConnectorEventHandler >> eventsToHandle [
	^ {
		GtConnectorVisualSourceElementAddedEvent.
		GtConnectorVisualTargetElementAddedEvent.
	}
]

{ #category : #'event handling' }
GtConnectorEventHandler >> visualSourceAdded: anEvent [
	self connector
		emitSignalForEvent: anEvent;
		drawLinesFromVisualSource: anEvent element;
		linkLayoutSourcesFor: anEvent element
]

{ #category : #'event handling' }
GtConnectorEventHandler >> visualTargetAdded: anEvent [
	self connector
		emitSignalForEvent: anEvent;
		drawLinesToVisualTarget: anEvent element;
		linkLayoutTargetsFor: anEvent element
]
