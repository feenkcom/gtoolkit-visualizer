Class {
	#name : #VocalBlElement,
	#superclass : #BlElement,
	#instVars : [
		'gtConnector'
	],
	#category : #'GToolkit-Connector'
}

{ #category : #accessing }
VocalBlElement >> gtConnector [
	^ gtConnector
]

{ #category : #accessing }
VocalBlElement >> gtConnector: anObject [
	gtConnector := anObject
]

{ #category : #'hooks - children' }
VocalBlElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph 
	gtConnector isNotNil ifTrue: [ gtConnector elementAddedToScene: self ].
	
]

{ #category : #'hooks - children' }
VocalBlElement >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph 
]
