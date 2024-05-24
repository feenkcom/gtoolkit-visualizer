Class {
	#name : #GtWardleyMapNodeViewModelTypeChanged,
	#superclass : #Announcement,
	#instVars : [
		'nodeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeViewModelTypeChanged >> nodeViewModel [
	^ nodeViewModel
]

{ #category : #accessing }
GtWardleyMapNodeViewModelTypeChanged >> nodeViewModel: anObject [
	nodeViewModel := anObject
]
