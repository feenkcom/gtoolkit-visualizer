Class {
	#name : #GtWardleyMapRemoveNoteChange,
	#superclass : #GtWardleyMapChange,
	#instVars : [
		'note'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #copying }
GtWardleyMapRemoveNoteChange >> copyForPreviewIn: previewMap using: mapping [
	| copy |
	copy := super copyForPreviewIn: previewMap using: mapping.
	note ifNotNil: [ copy note: (mapping at: note) ].
	^ copy
]

{ #category : #private }
GtWardleyMapRemoveNoteChange >> executeNotifying: aBlock [
	| undo |
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
	^ note
]

{ #category : #accessing }
GtWardleyMapRemoveNoteChange >> note: aNote [
	note := aNote
]
