Class {
	#name : #GtWardleyMapNodeLabelViewModelMoved,
	#superclass : #Announcement,
	#instVars : [
		'nodeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeLabelViewModelMoved >> nodeViewModel [
	^ nodeViewModel
]

{ #category : #accessing }
GtWardleyMapNodeLabelViewModelMoved >> nodeViewModel: anObject [
	nodeViewModel := anObject
]
