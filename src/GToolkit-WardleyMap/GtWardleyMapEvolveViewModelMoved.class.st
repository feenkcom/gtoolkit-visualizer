Class {
	#name : #GtWardleyMapEvolveViewModelMoved,
	#superclass : #Announcement,
	#instVars : [
		'evolveViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapEvolveViewModelMoved >> evolveViewModel [
	^ evolveViewModel
]

{ #category : #accessing }
GtWardleyMapEvolveViewModelMoved >> evolveViewModel: anObject [
	evolveViewModel := anObject
]

{ #category : #accessing }
GtWardleyMapEvolveViewModelMoved >> nodeViewModel [
	"Compatibility with node announcements"

	^ self evolveViewModel
]
