Class {
	#name : #GtConnectorContextEventSignal,
	#superclass : #GtConnectorBasicEventSignal,
	#instVars : [
		'elementRole'
	],
	#category : #'GToolkit-Connector-Logging'
}

{ #category : #accessing }
GtConnectorContextEventSignal >> elementRole [
	^ elementRole
]

{ #category : #accessing }
GtConnectorContextEventSignal >> elementRole: aSymbol [
	elementRole := aSymbol
]

{ #category : #printing }
GtConnectorContextEventSignal >> printOneLineContentsOn: stream [
	super printOneLineContentsOn: stream.
	stream 
		nextPutAll: ', ';
		nextPutAll: self elementRole
]

{ #category : #ui }
GtConnectorContextEventSignal >> signalDetails [
	^ super signalDetails, {
			'Role' -> self elementRole
		} 
]
