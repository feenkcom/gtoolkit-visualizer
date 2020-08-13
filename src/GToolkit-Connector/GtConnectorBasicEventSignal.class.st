Class {
	#name : #GtConnectorBasicEventSignal,
	#superclass : #GtConnectorBasicSignal,
	#instVars : [
		'event'
	],
	#category : #'GToolkit-Connector-Logging'
}

{ #category : #accessing }
GtConnectorBasicEventSignal >> event [
	^ event
]

{ #category : #accessing }
GtConnectorBasicEventSignal >> event: anObject [
	event := anObject
]

{ #category : #ui }
GtConnectorBasicEventSignal >> gtCurrentElementFor: aView [
	<gtView>
	^ (self gtCurrentTargetFor: aView)
		title: 'Current element';
		priority: 20
]

{ #category : #ui }
GtConnectorBasicEventSignal >> gtCurrentTargetFor: aView [
	<gtView>
	^ aView forward 
		title: 'Current target';
		priority: 25;
		object: [ self event ];
		view: #gtCurrentTargetFor:
]

{ #category : #ui }
GtConnectorBasicEventSignal >> gtDetailsFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Details';
		priority: 15;
		items: [ self signalDetails ];
		column: 'Name' text: #key;
		column: 'Value' text: #value
		
]

{ #category : #printing }
GtConnectorBasicEventSignal >> printOneLineContentsOn: stream [
	stream 
		nextPutAll: self event class name
]

{ #category : #ui }
GtConnectorBasicEventSignal >> signalDetails [
	^ {
			'Source event' -> self event.
			'Target hash' -> self event currentTarget hash 
		} 
]
