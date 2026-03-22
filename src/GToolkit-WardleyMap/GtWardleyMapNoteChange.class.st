Class {
	#name : #GtWardleyMapNoteChange,
	#superclass : #GtWardleyMapChange,
	#instVars : [
		'label',
		'evolution',
		'visibility',
		'color'
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
GtWardleyMapNoteChange >> label [
	^ label
]

{ #category : #accessing }
GtWardleyMapNoteChange >> label: aString [
	label := aString
]

{ #category : #accessing }
GtWardleyMapNoteChange >> visibility [
	^ visibility
]

{ #category : #accessing }
GtWardleyMapNoteChange >> visibility: aNumber [
	visibility := aNumber
]
