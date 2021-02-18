Class {
	#name : #GtWardleyMapNodeModelRemoved,
	#superclass : #Announcement,
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
