Class {
	#name : #GtConnectorElementContext,
	#superclass : #Object,
	#instVars : [
		'model',
		'isLayoutSource',
		'isLayoutTarget',
		'isVisualSource',
		'isVisualTarget',
		'element',
		'connectorConnections'
	],
	#category : #'GToolkit-Connector'
}

{ #category : #'instance creation' }
GtConnectorElementContext class >> on: anElement [
	^ self new 
		element: anElement;
		yourself
]

{ #category : #accessing }
GtConnectorElementContext >> beConnectedTo: anObject [ 
	connectorConnections isNil ifTrue: [ connectorConnections := Set new ].
	connectorConnections add: anObject.
]

{ #category : #accessing }
GtConnectorElementContext >> beLayoutSource [
	isLayoutSource := true
]

{ #category : #accessing }
GtConnectorElementContext >> beLayoutTarget [
	isLayoutTarget := true
]

{ #category : #accessing }
GtConnectorElementContext >> beNotConnectedTo: anObject [ 
	connectorConnections isNotNil ifTrue: [ connectorConnections remove: anObject ].
]

{ #category : #accessing }
GtConnectorElementContext >> beVisualSource [
	isVisualSource := true
]

{ #category : #accessing }
GtConnectorElementContext >> beVisualTarget [
	isVisualTarget := true
]

{ #category : #accessing }
GtConnectorElementContext >> element [
	^ element
]

{ #category : #accessing }
GtConnectorElementContext >> element: anObject [
	element := anObject
]

{ #category : #accessing }
GtConnectorElementContext >> initialize [
	isLayoutSource := false.
	isLayoutTarget := false.
	isVisualSource := false.
	isVisualTarget := false.
	
]

{ #category : #accessing }
GtConnectorElementContext >> isConnectedTo: anObject [ 
	^ 	connectorConnections isNotNil and: [ connectorConnections includes: anObject  ].
]

{ #category : #accessing }
GtConnectorElementContext >> isLayoutSource [
	^ isLayoutSource
]

{ #category : #accessing }
GtConnectorElementContext >> isLayoutSource: anObject [
	isLayoutSource := anObject
]

{ #category : #accessing }
GtConnectorElementContext >> isLayoutTarget [
	^ isLayoutTarget
]

{ #category : #accessing }
GtConnectorElementContext >> isLayoutTarget: anObject [
	isLayoutTarget := anObject
]

{ #category : #accessing }
GtConnectorElementContext >> isVisualSource [
	^ isVisualSource
]

{ #category : #accessing }
GtConnectorElementContext >> isVisualSource: anObject [
	isVisualSource := anObject
]

{ #category : #accessing }
GtConnectorElementContext >> isVisualTarget [
	^ isVisualTarget
]

{ #category : #accessing }
GtConnectorElementContext >> isVisualTarget: anObject [
	isVisualTarget := anObject
]

{ #category : #accessing }
GtConnectorElementContext >> model [
	^ model
]

{ #category : #accessing }
GtConnectorElementContext >> model: anObject [
	model := anObject
]
