Class {
	#name : #GtWardleyMapNodeViewModelResized,
	#superclass : #Announcement,
	#instVars : [
		'nodeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeViewModelResized >> nodeViewModel [
	^ nodeViewModel
]

{ #category : #accessing }
GtWardleyMapNodeViewModelResized >> nodeViewModel: anObject [
	nodeViewModel := anObject
]
