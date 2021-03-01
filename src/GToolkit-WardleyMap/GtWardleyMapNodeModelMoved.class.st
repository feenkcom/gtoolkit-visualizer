Class {
	#name : #GtWardleyMapNodeModelMoved,
	#superclass : #GtWardleyMapNodeModelAnnouncement,
	#instVars : [
		'nodeModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeModelMoved >> nodeModel [
	^ nodeModel
]

{ #category : #accessing }
GtWardleyMapNodeModelMoved >> nodeModel: anObject [
	nodeModel := anObject
]
