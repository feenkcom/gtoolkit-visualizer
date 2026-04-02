Class {
	#name : #GtWardleyMapNoteDecoratorViewModelAdded,
	#superclass : #Announcement,
	#instVars : [
		'noteViewModel',
		'decoratorViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNoteDecoratorViewModelAdded >> decoratorViewModel [
	^ decoratorViewModel
]

{ #category : #accessing }
GtWardleyMapNoteDecoratorViewModelAdded >> decoratorViewModel: anObject [
	decoratorViewModel := anObject
]

{ #category : #accessing }
GtWardleyMapNoteDecoratorViewModelAdded >> noteViewModel [
	^ noteViewModel
]

{ #category : #accessing }
GtWardleyMapNoteDecoratorViewModelAdded >> noteViewModel: anObject [
	noteViewModel := anObject
]
