Class {
	#name : #GtWardleyMapNodeViewModelLabelMoved,
	#superclass : #Announcement,
	#instVars : [
		'nodeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeViewModelLabelMoved >> nodeViewModel [
	^ nodeViewModel
]

{ #category : #accessing }
GtWardleyMapNodeViewModelLabelMoved >> nodeViewModel: anObject [
	nodeViewModel := anObject
]
