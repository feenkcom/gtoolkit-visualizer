Class {
	#name : #GtWardleyMapNoteChange,
	#superclass : #GtWardleyMapChange,
	#instVars : [
		'label',
		'evolution',
		'visibility',
		'color',
		'id'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #accessing }
GtWardleyMapNoteChange >> color [
	^ color
]

{ #category : #accessing }
GtWardleyMapNoteChange >> color: aColor [
	color := aColor
]

{ #category : #accessing }
GtWardleyMapNoteChange >> evolution [
	^ evolution
]

{ #category : #accessing }
GtWardleyMapNoteChange >> evolution: aNumber [
	evolution := aNumber
]

{ #category : #accessing }
GtWardleyMapNoteChange >> highlightModifications [
	| highlight |
	self execute.
	highlight := self highlight.
	self note addWardleyMapDecoratorModel: highlight
]

{ #category : #accessing }
GtWardleyMapNoteChange >> id [
	^ id
]

{ #category : #accessing }
GtWardleyMapNoteChange >> id: aString [
	id := aString
]

{ #category : #accessing }
GtWardleyMapNoteChange >> label [
	^ label
]

{ #category : #accessing }
GtWardleyMapNoteChange >> label: aString [
	label := aString
]

{ #category : #accessing }
GtWardleyMapNoteChange >> note [
	^ map
		noteWithId: (UUID gtFromString: id)
		ifFound: [ :each | each ]
		ifNone: [  ]
]

{ #category : #accessing }
GtWardleyMapNoteChange >> visibility [
	^ visibility
]

{ #category : #accessing }
GtWardleyMapNoteChange >> visibility: aNumber [
	visibility := aNumber
]
