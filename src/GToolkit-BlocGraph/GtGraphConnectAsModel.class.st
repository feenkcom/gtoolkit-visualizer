Class {
	#name : #GtGraphConnectAsModel,
	#superclass : #BlEvent,
	#instVars : [
		'model'
	],
	#category : #'GToolkit-BlocGraph-Events'
}

{ #category : #accessing }
GtGraphConnectAsModel >> model [
	^ model
]

{ #category : #accessing }
GtGraphConnectAsModel >> model: anObject [
	model := anObject
]
