Class {
	#name : #GtWardleyMapRemoveNoteChange,
	#superclass : #GtWardleyMapChange,
	#instVars : [
		'note'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #'as yet unclassified' }
GtWardleyMapRemoveNoteChange >> executeNotifying: aBlock [
	| undo |
	undo := GtWardleyMapAddNoteChange onMap: map andNote: note.
	map removeNote: note.
	^ undo
]

{ #category : #accessing }
GtWardleyMapRemoveNoteChange >> note [
	^ note
]

{ #category : #accessing }
GtWardleyMapRemoveNoteChange >> note: aNote [
	note := aNote
]
