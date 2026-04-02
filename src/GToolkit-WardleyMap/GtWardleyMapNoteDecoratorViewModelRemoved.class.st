Class {
	#name : #GtWardleyMapNoteDecoratorViewModelRemoved,
	#superclass : #Announcement,
	#instVars : [
		'noteViewModel',
		'decoratorViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNoteDecoratorViewModelRemoved >> decoratorViewModel [
	^ decoratorViewModel
]

{ #category : #accessing }
GtWardleyMapNoteDecoratorViewModelRemoved >> decoratorViewModel: anObject [
	decoratorViewModel := anObject
]

{ #category : #accessing }
GtWardleyMapNoteDecoratorViewModelRemoved >> noteViewModel [
	^ noteViewModel
]

{ #category : #accessing }
GtWardleyMapNoteDecoratorViewModelRemoved >> noteViewModel: anObject [
	noteViewModel := anObject
]
