Class {
	#name : #GtConnectorEventSignal,
	#superclass : #GtConnectorBasicEventSignal,
	#category : #'GToolkit-Connector-Logging'
}

{ #category : #ui }
GtConnectorEventSignal >> gtCurrentElementFor: aView [
	<gtView>
	^ aView forward 
		title: 'Current element';
		priority: 20;
		object: [ self event element ];
		view: #gtPreviewFor:
]

{ #category : #ui }
GtConnectorEventSignal >> signalDetails [
	^ super signalDetails, {
			'Current element hash' -> self event element hash 
		} 
]
