Class {
	#name : #GtWardleyMapNoteDecoratorContext,
	#superclass : #GtWardleyMapDecoratorContext,
	#instVars : [
		'noteViewModel',
		'noteElement'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #enumerating }
GtWardleyMapNoteDecoratorContext >> labelContainerDo: aBlock [
	self noteElement labelContainerDo: aBlock
]

{ #category : #accessing }
GtWardleyMapNoteDecoratorContext >> noteElement [
	^ noteElement
]

{ #category : #accessing }
GtWardleyMapNoteDecoratorContext >> noteElement: anObject [
	noteElement := anObject
]

{ #category : #accessing }
GtWardleyMapNoteDecoratorContext >> noteViewModel [
	^ noteViewModel
]

{ #category : #accessing }
GtWardleyMapNoteDecoratorContext >> noteViewModel: anObject [
	noteViewModel := anObject
]
