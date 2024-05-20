Class {
	#name : #GtWardleyMapNoteViewModelRemoved,
	#superclass : #Announcement,
	#instVars : [
		'noteViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNoteViewModelRemoved >> noteViewModel [
	^ noteViewModel
]

{ #category : #accessing }
GtWardleyMapNoteViewModelRemoved >> noteViewModel: anObject [
	noteViewModel := anObject
]
