Class {
	#name : #GtWardleyMapNodeLabelModelTextChanged,
	#superclass : #Announcement,
	#instVars : [
		'nodeLabelModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeLabelModelTextChanged >> nodeLabelModel [
	^ nodeLabelModel
]

{ #category : #accessing }
GtWardleyMapNodeLabelModelTextChanged >> nodeLabelModel: anObject [
	nodeLabelModel := anObject
]
