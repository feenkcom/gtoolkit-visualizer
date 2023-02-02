Class {
	#name : #GtWardleyMapNodeViewModelPipelineVisibilityChanged,
	#superclass : #Announcement,
	#instVars : [
		'nodeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeViewModelPipelineVisibilityChanged >> nodeViewModel [
	^ nodeViewModel
]

{ #category : #accessing }
GtWardleyMapNodeViewModelPipelineVisibilityChanged >> nodeViewModel: anObject [
	nodeViewModel := anObject
]
