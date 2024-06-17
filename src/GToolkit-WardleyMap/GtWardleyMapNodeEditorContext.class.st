Class {
	#name : #GtWardleyMapNodeEditorContext,
	#superclass : #Object,
	#instVars : [
		'editorElement'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #accessing }
GtWardleyMapNodeEditorContext >> editorElement [
	^ editorElement
]

{ #category : #accessing }
GtWardleyMapNodeEditorContext >> editorElement: aGtWardleyMapNodeEditorElement [
	editorElement := aGtWardleyMapNodeEditorElement
]

{ #category : #accessing }
GtWardleyMapNodeEditorContext >> wardleyMapNodeViewModel [
	^ self editorElement wardleyMapNodeViewModel
]

{ #category : #accessing }
GtWardleyMapNodeEditorContext >> wardleyMapViewModel [
	^ self editorElement wardleyMapViewModel
]
