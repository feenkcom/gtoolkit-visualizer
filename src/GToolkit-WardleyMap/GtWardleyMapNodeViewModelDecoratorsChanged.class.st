Class {
	#name : #GtWardleyMapNodeViewModelDecoratorsChanged,
	#superclass : #Announcement,
	#instVars : [
		'nodeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeViewModelDecoratorsChanged >> nodeViewModel [
	^ nodeViewModel
]

{ #category : #accessing }
GtWardleyMapNodeViewModelDecoratorsChanged >> nodeViewModel: anObject [
	nodeViewModel := anObject
]