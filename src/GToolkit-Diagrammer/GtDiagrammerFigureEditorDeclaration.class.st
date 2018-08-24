Class {
	#name : #GtDiagrammerFigureEditorDeclaration,
	#superclass : #Object,
	#instVars : [
		'condition',
		'editors'
	],
	#category : 'GToolkit-Diagrammer-Model'
}

{ #category : #accessing }
GtDiagrammerFigureEditorDeclaration >> condition [
	^ condition
]

{ #category : #accessing }
GtDiagrammerFigureEditorDeclaration >> condition: aBlock [
	condition := aBlock
]

{ #category : #accessing }
GtDiagrammerFigureEditorDeclaration >> editor: anObjectBlock [
	editors := anObjectBlock
]

{ #category : #computing }
GtDiagrammerFigureEditorDeclaration >> editors [
	<return: #Array of: #GtDiagrammerFigureEditor>

	^ (self meetsCondition
		ifTrue: [ editors value ]
		ifFalse: [ #() ]) asOrderedCollection asArray
]

{ #category : #accessing }
GtDiagrammerFigureEditorDeclaration >> editors: anObjectBlock [
	editors := anObjectBlock
]

{ #category : #initialization }
GtDiagrammerFigureEditorDeclaration >> initialize [
	super  initialize.
	
	condition := true.
	editors := #()
]

{ #category : #testing }
GtDiagrammerFigureEditorDeclaration >> meetsCondition [
	<return: #Boolean>

	^ condition value
]
