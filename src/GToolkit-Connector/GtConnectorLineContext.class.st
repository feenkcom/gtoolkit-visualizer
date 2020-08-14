Class {
	#name : #GtConnectorLineContext,
	#superclass : #Object,
	#instVars : [
		'lineElement',
		'fromElement',
		'toElement'
	],
	#category : #'GToolkit-Connector-Core'
}

{ #category : #'instance creation' }
GtConnectorLineContext class >> on: anElement [
	^ self new 
		lineElement: anElement;
		yourself
]

{ #category : #accessing }
GtConnectorLineContext >> fromElement [
	^ fromElement
]

{ #category : #accessing }
GtConnectorLineContext >> fromElement: anObject [
	fromElement := anObject
]

{ #category : #accessing }
GtConnectorLineContext >> lineElement [
	^ lineElement
]

{ #category : #accessing }
GtConnectorLineContext >> lineElement: anObject [
	lineElement := anObject
]

{ #category : #accessing }
GtConnectorLineContext >> toElement [
	^ toElement
]

{ #category : #accessing }
GtConnectorLineContext >> toElement: anObject [
	toElement := anObject
]
