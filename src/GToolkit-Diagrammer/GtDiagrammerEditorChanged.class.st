"
I am notified by an editor when its graphical representation should be recreated due to underlying element or model changes.


"
Class {
	#name : #GtDiagrammerEditorChanged,
	#superclass : #Announcement,
	#instVars : [
		'editor'
	],
	#category : #'GToolkit-Diagrammer-Model'
}

{ #category : #'instance creation' }
GtDiagrammerEditorChanged class >> editor: aGtDiagrammerFigureEditor [
	^ self new editor: aGtDiagrammerFigureEditor
]

{ #category : #accessing }
GtDiagrammerEditorChanged >> editor [
	<return: #GtDiagrammerFigureEditor>

	^ editor
]

{ #category : #accessing }
GtDiagrammerEditorChanged >> editor: aGtDiagrammerFigureEditor [
	editor := aGtDiagrammerFigureEditor
]
