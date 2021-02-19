Class {
	#name : #GtWardleyMapNodeModelMoved,
	#superclass : #Announcement,
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
