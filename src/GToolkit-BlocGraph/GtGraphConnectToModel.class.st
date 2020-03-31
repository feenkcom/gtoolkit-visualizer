Class {
	#name : #GtGraphConnectToModel,
	#superclass : #BlEvent,
	#instVars : [
		'fromModel',
		'toModel'
	],
	#category : #'GToolkit-BlocGraph-Events'
}

{ #category : #accessing }
GtGraphConnectToModel >> fromModel [
	^ fromModel
]

{ #category : #accessing }
GtGraphConnectToModel >> fromModel: anObject [
	fromModel := anObject
]

{ #category : #accessing }
GtGraphConnectToModel >> toModel [
	^ toModel
]

{ #category : #accessing }
GtGraphConnectToModel >> toModel: anObject [
	toModel := anObject
]
