Class {
	#name : #GtWardleyMapUpdateNoteChange,
	#superclass : #GtWardleyMapNoteChange,
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #private }
GtWardleyMapUpdateNoteChange >> executeNotifying: aBlock [
	| undo |
	undo := self copy.
	self note
		ifNotNil: [ :note | 
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
					note visibility: visibility ] ].
	^ undo
]

{ #category : #accessing }
GtWardleyMapUpdateNoteChange >> note: aNote [
	id := aNote id asString36
]
