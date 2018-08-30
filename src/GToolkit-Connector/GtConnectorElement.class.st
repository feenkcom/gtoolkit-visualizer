Class {
	#name : #GtConnectorElement,
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
GtConnectorElement class >> on: anElement [
	^ self new 
		element: anElement;
		yourself
]

{ #category : #accessing }
GtConnectorElement >> beConnectedTo: anObject [ 
	connectorConnections isNil ifTrue: [ connectorConnections := Set new ].
	connectorConnections add: anObject.
]

{ #category : #accessing }
GtConnectorElement >> beLayoutSource [
	isLayoutSource := true
]

{ #category : #accessing }
GtConnectorElement >> beLayoutTarget [
	isLayoutTarget := true
]

{ #category : #accessing }
GtConnectorElement >> beVisualSource [
	isVisualSource := true
]

{ #category : #accessing }
GtConnectorElement >> beVisualTarget [
	isVisualTarget := true
]

{ #category : #accessing }
GtConnectorElement >> element [
	^ element
]

{ #category : #accessing }
GtConnectorElement >> element: anObject [
	element := anObject
]

{ #category : #accessing }
GtConnectorElement >> initialize [
	isLayoutSource := false.
	isLayoutTarget := false.
	isVisualSource := false.
	isVisualTarget := false.
	
]

{ #category : #accessing }
GtConnectorElement >> isConnectedTo: anObject [ 
	^ 	connectorConnections isNotNil and: [ connectorConnections includes: anObject  ].
]

{ #category : #accessing }
GtConnectorElement >> isLayoutSource [
	^ isLayoutSource
]

{ #category : #accessing }
GtConnectorElement >> isLayoutSource: anObject [
	isLayoutSource := anObject
]

{ #category : #accessing }
GtConnectorElement >> isLayoutTarget [
	^ isLayoutTarget
]

{ #category : #accessing }
GtConnectorElement >> isLayoutTarget: anObject [
	isLayoutTarget := anObject
]

{ #category : #accessing }
GtConnectorElement >> isVisualSource [
	^ isVisualSource
]

{ #category : #accessing }
GtConnectorElement >> isVisualSource: anObject [
	isVisualSource := anObject
]

{ #category : #accessing }
GtConnectorElement >> isVisualTarget [
	^ isVisualTarget
]

{ #category : #accessing }
GtConnectorElement >> isVisualTarget: anObject [
	isVisualTarget := anObject
]

{ #category : #accessing }
GtConnectorElement >> model [
	^ model
]

{ #category : #accessing }
GtConnectorElement >> model: anObject [
	model := anObject
]
