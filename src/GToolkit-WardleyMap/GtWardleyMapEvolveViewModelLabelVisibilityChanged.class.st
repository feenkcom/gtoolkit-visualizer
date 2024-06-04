Class {
	#name : #GtWardleyMapEvolveViewModelLabelVisibilityChanged,
	#superclass : #Announcement,
	#instVars : [
		'evolveViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapEvolveViewModelLabelVisibilityChanged >> evolveViewModel [
	^ evolveViewModel
]

{ #category : #accessing }
GtWardleyMapEvolveViewModelLabelVisibilityChanged >> evolveViewModel: anObject [
	evolveViewModel := anObject
]
