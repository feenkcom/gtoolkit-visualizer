Class {
	#name : #GtWardleyMapNoteModelAnnouncement,
	#superclass : #GtWardleyMapAnnouncement,
	#instVars : [
		'noteModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNoteModelAnnouncement >> noteModel [
	<return: #GtWardleyMapNoteModel>
	^ noteModel
]

{ #category : #accessing }
GtWardleyMapNoteModelAnnouncement >> noteModel: anObject [
	noteModel := anObject
]
