Class {
	#name : #GtWardleyMapNoteModelAdded,
	#superclass : #GtWardleyMapModelAnnouncement,
	#instVars : [
		'noteModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNoteModelAdded >> noteModel [
	^ noteModel
]

{ #category : #accessing }
GtWardleyMapNoteModelAdded >> noteModel: anObject [
	noteModel := anObject
]
