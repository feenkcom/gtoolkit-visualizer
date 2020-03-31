Class {
	#name : #GtGraphTryConnectToModel,
	#superclass : #BlEvent,
	#instVars : [
		'model'
	],
	#category : #'GToolkit-BlocGraph-Events'
}

{ #category : #accessing }
GtGraphTryConnectToModel >> model [
	^ model
]

{ #category : #accessing }
GtGraphTryConnectToModel >> model: anObject [
	model := anObject
]
