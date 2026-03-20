Class {
	#name : #GtWardleyMapUpdateNoteChange,
	#superclass : #GtWardleyMapNoteChange,
	#instVars : [
		'note'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #'as yet unclassified' }
GtWardleyMapUpdateNoteChange >> executeNotifying: aBlock [
	| undo |
	undo := self copy.
	color
		ifNotNil: [ undo color: note color.
			note color: color ].
	evolution
		ifNotNil: [ undo evolution: note evolution.
			note evolution: evolution ].
	label
		ifNotNil: [ undo label: note label.
			note label: label ].
	visibility
		ifNotNil: [ undo visibility: note visibility.
			note visibility: visibility ].
	^ undo
]

{ #category : #accessing }
GtWardleyMapUpdateNoteChange >> note [
	^ note
]

{ #category : #accessing }
GtWardleyMapUpdateNoteChange >> note: aNote [
	note := aNote
]
