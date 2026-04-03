Class {
	#name : #GtWardleyMapRemoveNoteChange,
	#superclass : #GtWardleyMapChange,
	#instVars : [
		'noteId'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #private }
GtWardleyMapRemoveNoteChange >> executeNotifying: aBlock [
	| undo note |
	note := self note.
	undo := GtWardleyMapAddNoteChange onMap: map andNote: note.
	map removeNote: note.
	^ undo
]

{ #category : #accessing }
GtWardleyMapRemoveNoteChange >> highlightModifications [
	| highlight |
	highlight := self highlight.
	self note addWardleyMapDecoratorModel: highlight
]

{ #category : #accessing }
GtWardleyMapRemoveNoteChange >> highlightType [
	^ #remove
]

{ #category : #accessing }
GtWardleyMapRemoveNoteChange >> note [
	^ map
		noteWithId: (UUID gtFromString: noteId)
		ifFound: [ :each | each ]
		ifNone: [  ]
]

{ #category : #accessing }
GtWardleyMapRemoveNoteChange >> note: aNote [
	noteId := aNote id asString36
]

{ #category : #accessing }
GtWardleyMapRemoveNoteChange >> noteId [
	^ noteId
]

{ #category : #accessing }
GtWardleyMapRemoveNoteChange >> noteId: anObject [
	noteId := anObject
]
