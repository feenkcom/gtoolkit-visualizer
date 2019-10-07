Class {
	#name : #BlElementAddedToSceneGraph,
	#superclass : #BlEvent,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-Connector'
}

{ #category : #accessing }
BlElementAddedToSceneGraph >> element [
	^ element
]

{ #category : #accessing }
BlElementAddedToSceneGraph >> element: anObject [
	element := anObject
]
