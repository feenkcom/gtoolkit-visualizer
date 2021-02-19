Class {
	#name : #GtWardleyMapNodeLabelModelMoved,
	#superclass : #Announcement,
	#instVars : [
		'nodeLabelModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeLabelModelMoved >> nodeLabelModel [
	^ nodeLabelModel
]

{ #category : #accessing }
GtWardleyMapNodeLabelModelMoved >> nodeLabelModel: anObject [
	nodeLabelModel := anObject
]
