Class {
	#name : #GtWardleyMapNodeViewModelEvolveVisibilityChanged,
	#superclass : #Announcement,
	#instVars : [
		'nodeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeViewModelEvolveVisibilityChanged >> nodeViewModel [
	^ nodeViewModel
]

{ #category : #accessing }
GtWardleyMapNodeViewModelEvolveVisibilityChanged >> nodeViewModel: anObject [
	nodeViewModel := anObject
]
