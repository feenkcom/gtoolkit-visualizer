Class {
	#name : #GtWardleyMapEditorContext,
	#superclass : #Object,
	#instVars : [
		'editorElement'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #accessing }
GtWardleyMapEditorContext >> canvasElement [
	^ self editorElement canvas
]

{ #category : #accessing }
GtWardleyMapEditorContext >> canvasWithSectionsElement [
	self canvasElement allParentsDo: [ :aParent | 
		(aParent isKindOf: GtWardleyMapElement) 
			ifTrue: [ ^ aParent ] ].
	^ nil
]

{ #category : #accessing }
GtWardleyMapEditorContext >> editorElement [
	^ editorElement
]

{ #category : #accessing }
GtWardleyMapEditorContext >> editorElement: aGtWardleyMapNodeEditorElement [
	editorElement := aGtWardleyMapNodeEditorElement
]

{ #category : #accessing }
GtWardleyMapEditorContext >> wardleyMapViewModel [
	^ self editorElement wardleyMapViewModel
]
