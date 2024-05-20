Class {
	#name : #GtWardleyMapNoteModelRemoved,
	#superclass : #GtWardleyMapModelAnnouncement,
	#instVars : [
		'noteModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNoteModelRemoved >> noteModel [
	^ noteModel
]

{ #category : #accessing }
GtWardleyMapNoteModelRemoved >> noteModel: anObject [
	noteModel := anObject
]
