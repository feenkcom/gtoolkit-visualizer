Class {
	#name : #GtWardleyMapNodeModelAdded,
	#superclass : #GtWardleyMapModelAnnouncement,
	#instVars : [
		'nodeModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeModelAdded >> nodeModel [
	^ nodeModel
]

{ #category : #accessing }
GtWardleyMapNodeModelAdded >> nodeModel: anObject [
	nodeModel := anObject
]
