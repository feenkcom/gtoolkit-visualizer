Class {
	#name : #BlElementRemovedFromSceneGraph,
	#superclass : #BlEvent,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-Connector'
}

{ #category : #accessing }
BlElementRemovedFromSceneGraph >> element [
	^ element
]

{ #category : #accessing }
BlElementRemovedFromSceneGraph >> element: anObject [
	element := anObject
]
