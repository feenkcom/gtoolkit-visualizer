Class {
	#name : #GtConnectorBasicSignal,
	#superclass : #BeaconSignal,
	#category : #'GToolkit-Connector-Logging'
}

{ #category : #testing }
GtConnectorBasicSignal class >> gtNormalOperationSignal [
	"Answer a Boolean indicating whether this signal is generated as part of normal operations.
	See {{gtMethod:BeaconSignal class>>gtNormalOperationSignal}} for a description"

	^ true.
]
