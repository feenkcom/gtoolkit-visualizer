Class {
	#name : #GtWardleyMapAddNoteChange,
	#superclass : #GtWardleyMapChange,
	#instVars : [
		'label',
		'evolution',
		'visibility',
		'newNote',
		'color'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #'as yet unclassified' }
GtWardleyMapAddNoteChange class >> onMap: aMap andNote: aNote [
	| undo |
	undo := self onMap: aMap.
	undo color: aNote color.
	undo evolution: aNote evolution.
	undo label: aNote label.
	undo visibility: aNote visibility.
	^ undo
]

{ #category : #accessing }
GtWardleyMapAddNoteChange >> color [
	^ color
]

{ #category : #accessing }
GtWardleyMapAddNoteChange >> color: aColor [
	color := aColor
]

{ #category : #accessing }
GtWardleyMapAddNoteChange >> evolution [
	^ evolution
]

{ #category : #accessing }
GtWardleyMapAddNoteChange >> evolution: aNumber [
	evolution := aNumber
]

{ #category : #'as yet unclassified' }
GtWardleyMapAddNoteChange >> executeNotifying: aBlock [
	newNote := GtWardleyMapNoteModel new.
	color ifNotNil: [ newNote color: color ].
	evolution ifNotNil: [ newNote evolution: evolution ].
	label ifNotNil: [ newNote label: label ].
	visibility ifNotNil: [ newNote visibility: visibility ].
	map addNote: newNote.
	^ (GtWardleyMapRemoveNoteChange onMap: map) note: newNote
]

{ #category : #accessing }
GtWardleyMapAddNoteChange >> label [
	^ label
]

{ #category : #accessing }
GtWardleyMapAddNoteChange >> label: aString [
	label := aString
]

{ #category : #accessing }
GtWardleyMapAddNoteChange >> newNote [
	^ newNote
]

{ #category : #accessing }
GtWardleyMapAddNoteChange >> visibility [
	^ visibility
]

{ #category : #accessing }
GtWardleyMapAddNoteChange >> visibility: aNumber [
	visibility := aNumber
]
