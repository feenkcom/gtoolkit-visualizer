Class {
	#name : #GtWardleyMapNodeViewModelLabelTextChanged,
	#superclass : #Announcement,
	#instVars : [
		'nodeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeViewModelLabelTextChanged >> nodeViewModel [
	^ nodeViewModel
]

{ #category : #accessing }
GtWardleyMapNodeViewModelLabelTextChanged >> nodeViewModel: anObject [
	nodeViewModel := anObject
]
