Class {
	#name : #GtConnectorNode,
	#superclass : #Object,
	#instVars : [
		'source',
		'target',
		'element',
		'connectorConnections'
	],
	#category : #'GToolkit-Connector'
}

{ #category : #'instance creation' }
GtConnectorNode class >> on: anElement [
	^ self new 
		element: anElement;
		yourself
]

{ #category : #accessing }
GtConnectorNode >> beConnectedTo: anObject [
	connectorConnections isNil ifTrue: [ connectorConnections := Set new ].
	connectorConnections add: anObject.

]

{ #category : #accessing }
GtConnectorNode >> element [
	^ element
]

{ #category : #accessing }
GtConnectorNode >> element: anObject [
	element := anObject
]

{ #category : #accessing }
GtConnectorNode >> isConnectedTo: anObject [
	^ 	connectorConnections isNotNil and: [ connectorConnections contains: anObject  ].

]

{ #category : #accessing }
GtConnectorNode >> source [
	^ source
]

{ #category : #accessing }
GtConnectorNode >> source: aSource [
	source := aSource
]

{ #category : #accessing }
GtConnectorNode >> target [
	^ target
]

{ #category : #accessing }
GtConnectorNode >> target: anObject [
	target := anObject
]
