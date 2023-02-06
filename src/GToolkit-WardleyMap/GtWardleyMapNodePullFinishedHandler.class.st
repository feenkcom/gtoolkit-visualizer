Class {
	#name : #GtWardleyMapNodePullFinishedHandler,
	#superclass : #Object,
	#instVars : [
		'containerElement'
	],
	#category : #'GToolkit-WardleyMap-Helperss'
}

{ #category : #accessing }
GtWardleyMapNodePullFinishedHandler >> containerElement [
	^ containerElement
]

{ #category : #accessing }
GtWardleyMapNodePullFinishedHandler >> containerElement: anObject [
	containerElement := anObject
]

{ #category : #'api - event handling' }
GtWardleyMapNodePullFinishedHandler >> value: aPulledElement value: aDragDirection [
	aDragDirection ifNil: [ ^ self ].
	self containerElement ifNil: [ ^ self ].
	aDragDirection onPullFinished: aPulledElement mapElement: self containerElement
]
