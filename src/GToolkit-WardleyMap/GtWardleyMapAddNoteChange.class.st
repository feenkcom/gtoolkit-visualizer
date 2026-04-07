Class {
	#name : #GtWardleyMapAddNoteChange,
	#superclass : #GtWardleyMapNoteChange,
	#instVars : [
		'newNote'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #'instance creation' }
GtWardleyMapAddNoteChange class >> onMap: aMap andNote: aNote [
	| undo |
	undo := self onMap: aMap.
	undo id: aNote id asString36.
	undo color: aNote color.
	undo evolution: aNote evolution.
	undo label: aNote label.
	undo visibility: aNote visibility.
	^ undo
]

{ #category : #private }
GtWardleyMapAddNoteChange >> executeNotifying: aBlock [
	newNote := GtWardleyMapNoteModel new.
	color ifNotNil: [ newNote color: color ].
	evolution ifNotNil: [ newNote evolution: evolution ].
	id ifNotNil: [ newNote id: (UUID gtFromString: id) ].
	label ifNotNil: [ newNote label: label ].
	visibility ifNotNil: [ newNote visibility: visibility ].
	map addNote: newNote.
	^ (GtWardleyMapRemoveNoteChange onMap: map) note: newNote
]

{ #category : #accessing }
GtWardleyMapAddNoteChange >> highlightType [
	^ #add
]

{ #category : #accessing }
GtWardleyMapAddNoteChange >> newNote [
	^ newNote
]

{ #category : #accessing }
GtWardleyMapAddNoteChange >> note [
	^ self newNote
]
