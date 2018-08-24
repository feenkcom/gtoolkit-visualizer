Class {
	#name : #GtDiagrammerCompositeEditor,
	#superclass : #Object,
	#instVars : [
		'editors'
	],
	#category : 'GToolkit-Diagrammer-Model'
}

{ #category : #initialization }
GtDiagrammerCompositeEditor >> editors [
	^ editors
]

{ #category : #initialization }
GtDiagrammerCompositeEditor >> initialize [
	super initialize.
	
	editors := OrderedCollection new
]

{ #category : #accessing }
GtDiagrammerCompositeEditor >> with [
	| anEditor |
	
	anEditor := GtDiagrammerFigureEditor new.
	self editors add: anEditor.
	^ anEditor
]

{ #category : #accessing }
GtDiagrammerCompositeEditor >> with: aCollectionOfEditors [
	self editors add: aCollectionOfEditors
]
