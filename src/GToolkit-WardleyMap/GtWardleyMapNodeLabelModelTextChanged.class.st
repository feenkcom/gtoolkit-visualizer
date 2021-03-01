Class {
	#name : #GtWardleyMapNodeLabelModelTextChanged,
	#superclass : #GtWardleyMapNodeLabelModelAnnouncement,
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
