Class {
	#name : #GtWardleyMapNodeModelInnerNodeRemoved,
	#superclass : #GtWardleyMapNodeModelAnnouncement,
	#instVars : [
		'innerNodeModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeModelInnerNodeRemoved >> innerNodeModel [
	^ innerNodeModel
]

{ #category : #accessing }
GtWardleyMapNodeModelInnerNodeRemoved >> innerNodeModel: anObject [
	innerNodeModel := anObject
]
