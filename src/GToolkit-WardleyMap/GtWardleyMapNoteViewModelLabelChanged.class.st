Class {
	#name : #GtWardleyMapNoteViewModelLabelChanged,
	#superclass : #Announcement,
	#instVars : [
		'noteViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNoteViewModelLabelChanged >> noteViewModel [
	^ noteViewModel
]

{ #category : #accessing }
GtWardleyMapNoteViewModelLabelChanged >> noteViewModel: anObject [
	noteViewModel := anObject
]
