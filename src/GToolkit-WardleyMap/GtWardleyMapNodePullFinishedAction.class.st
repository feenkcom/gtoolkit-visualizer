Class {
	#name : #GtWardleyMapNodePullFinishedAction,
	#superclass : #Object,
	#instVars : [
		'containerElement'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #accessing }
GtWardleyMapNodePullFinishedAction >> containerElement [
	^ containerElement
]

{ #category : #accessing }
GtWardleyMapNodePullFinishedAction >> containerElement: anObject [
	containerElement := anObject
]

{ #category : #'api - event handling' }
GtWardleyMapNodePullFinishedAction >> value: aPulledElement value: aDragDirection [
	aDragDirection ifNil: [ ^ self ].
	self containerElement ifNil: [ ^ self ].
	aDragDirection onPullFinished: aPulledElement mapElement: self containerElement
]
