Class {
	#name : #GtWardleyMapUpdateMapChange,
	#superclass : #GtWardleyMapChange,
	#instVars : [
		'isTitleVisible',
		'isEvolutionAxisVisible',
		'title'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #'as yet unclassified' }
GtWardleyMapUpdateMapChange >> executeNotifying: aBlock [
	| undo |
	undo := self copy.
	isEvolutionAxisVisible
		ifNotNil: [ undo isEvolutionAxisVisible: map isEvolutionAxisVisible.
			map isEvolutionAxisVisible: isEvolutionAxisVisible ].
	isTitleVisible
		ifNotNil: [ undo isTitleVisible: map isTitleVisible.
			map isTitleVisible: isTitleVisible ].
	title
		ifNotNil: [ undo title: map title.
			map title: title ].
	^ undo
]

{ #category : #accessing }
GtWardleyMapUpdateMapChange >> isEvolutionAxisVisible [
	^ isEvolutionAxisVisible
]

{ #category : #accessing }
GtWardleyMapUpdateMapChange >> isEvolutionAxisVisible: anObject [
	isEvolutionAxisVisible := anObject
]

{ #category : #accessing }
GtWardleyMapUpdateMapChange >> isTitleVisible [
	^ isTitleVisible
]

{ #category : #accessing }
GtWardleyMapUpdateMapChange >> isTitleVisible: anObject [
	isTitleVisible := anObject
]

{ #category : #accessing }
GtWardleyMapUpdateMapChange >> title [
	^ title
]

{ #category : #accessing }
GtWardleyMapUpdateMapChange >> title: anObject [
	title := anObject
]
