Class {
	#name : #GtWardleyMapNodeViewModelMoved,
	#superclass : #Announcement,
	#instVars : [
		'nodeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeViewModelMoved >> nodeViewModel [
	^ nodeViewModel
]

{ #category : #accessing }
GtWardleyMapNodeViewModelMoved >> nodeViewModel: anObject [
	nodeViewModel := anObject
]
