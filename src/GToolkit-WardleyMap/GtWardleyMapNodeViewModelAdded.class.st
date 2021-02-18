Class {
	#name : #GtWardleyMapNodeViewModelAdded,
	#superclass : #Announcement,
	#instVars : [
		'nodeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeViewModelAdded >> nodeViewModel [
	^ nodeViewModel
]

{ #category : #accessing }
GtWardleyMapNodeViewModelAdded >> nodeViewModel: anObject [
	nodeViewModel := anObject
]
