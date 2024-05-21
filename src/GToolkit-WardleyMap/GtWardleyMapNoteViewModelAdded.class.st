Class {
	#name : #GtWardleyMapNoteViewModelAdded,
	#superclass : #Announcement,
	#instVars : [
		'noteViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNoteViewModelAdded >> noteViewModel [
	^ noteViewModel
]

{ #category : #accessing }
GtWardleyMapNoteViewModelAdded >> noteViewModel: anObject [
	noteViewModel := anObject
]
