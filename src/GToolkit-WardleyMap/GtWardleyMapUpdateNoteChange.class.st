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
		ifNotNil: [ undo color: self note color.
			self note color: color ].
	evolution
		ifNotNil: [ undo evolution: self note evolution.
			self note evolution: evolution ].
	label
		ifNotNil: [ undo label: self note label.
			self note label: label ].
	visibility
		ifNotNil: [ undo visibility: self note visibility.
			self note visibility: visibility ].
	^ undo
]

{ #category : #accessing }
GtWardleyMapUpdateNoteChange >> note [
	^ note
		ifNil: [ note := map
					noteWithId: id
					ifFound: [ :each | each ]
					ifNone: [  ] ]
]

{ #category : #accessing }
GtWardleyMapUpdateNoteChange >> note: aNote [
	note := aNote
]
