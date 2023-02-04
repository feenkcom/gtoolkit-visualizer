Class {
	#name : #GtWardleyMapNodeModelPipelineVisibilityChanged,
	#superclass : #GtWardleyMapNodeModelAnnouncement,
	#instVars : [
		'nodeModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeModelPipelineVisibilityChanged >> nodeModel [
	^ nodeModel
]

{ #category : #accessing }
GtWardleyMapNodeModelPipelineVisibilityChanged >> nodeModel: anObject [
	nodeModel := anObject
]
