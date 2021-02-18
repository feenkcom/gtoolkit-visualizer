Class {
	#name : #GtWardleyMapNodeViewModelRemoved,
	#superclass : #Announcement,
	#instVars : [
		'nodeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeViewModelRemoved >> nodeViewModel [
	^ nodeViewModel
]

{ #category : #accessing }
GtWardleyMapNodeViewModelRemoved >> nodeViewModel: anObject [
	nodeViewModel := anObject
]
