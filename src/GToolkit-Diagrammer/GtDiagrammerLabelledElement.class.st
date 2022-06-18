"
I am a stencil element with a text input field that can be switched in a edit mode with the help of a double click


"
Class {
	#name : #GtDiagrammerLabelledElement,
	#superclass : #BlElement,
	#instVars : [
		'editor',
		'editorElement'
	],
	#category : #'GToolkit-Diagrammer-Stencils'
}

{ #category : #initialization }
GtDiagrammerLabelledElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
GtDiagrammerLabelledElement >> initialize [
	super initialize.

	self size: 75@50.
	self border: (BlBorder paint: Color black width: 1).
	self background: Color white.
	self initializeEditor.
]

{ #category : #initialization }
GtDiagrammerLabelledElement >> initializeEditor [
	editor := BrTextEditorModel new.
	editorElement := BrEditorElement new.
	editorElement editor: editor.
	editorElement beDiagrammerSelectionLeaf.
	editorElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent.
		c frame horizontal alignCenter.
		c frame vertical alignCenter.
		c padding: (BlInsets all: 5)].
	
	self addChild: editorElement
]
