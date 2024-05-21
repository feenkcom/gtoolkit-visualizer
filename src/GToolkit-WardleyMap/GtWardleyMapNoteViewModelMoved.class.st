Class {
	#name : #GtWardleyMapNoteViewModelMoved,
	#superclass : #Announcement,
	#instVars : [
		'noteViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNoteViewModelMoved >> noteViewModel [
	^ noteViewModel
]

{ #category : #accessing }
GtWardleyMapNoteViewModelMoved >> noteViewModel: anObject [
	noteViewModel := anObject
]
