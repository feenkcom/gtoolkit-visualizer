Class {
	#name : #GtWardleyMapNodeModelRemoved,
	#superclass : #GtWardleyMapModelAnnouncement,
	#instVars : [
		'nodeModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeModelRemoved >> nodeModel [
	^ nodeModel
]

{ #category : #accessing }
GtWardleyMapNodeModelRemoved >> nodeModel: anObject [
	nodeModel := anObject
]
