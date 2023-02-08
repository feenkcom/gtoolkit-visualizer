Class {
	#name : #GtWardleyMapNodePulledAction,
	#superclass : #Object,
	#instVars : [
		'containerElement'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #accessing }
GtWardleyMapNodePulledAction >> containerElement [
	^ containerElement
]

{ #category : #accessing }
GtWardleyMapNodePulledAction >> containerElement: anObject [
	containerElement := anObject
]

{ #category : #'api - event handling' }
GtWardleyMapNodePulledAction >> value: aPulledElement value: aNormalizedPosition value: aDragDirection [
	self containerElement ifNil: [ ^ self ].
	aPulledElement hasWardleyMapNodeViewModel ifFalse: [ ^ self ].

	"We need to first move the node, then may expand pipeline"
	aPulledElement wardleyMapNodeViewModel moveNodeTo: aNormalizedPosition.

	aDragDirection
		ifNotNil: [ aDragDirection onPulled: aPulledElement mapElement: self containerElement ]
]
