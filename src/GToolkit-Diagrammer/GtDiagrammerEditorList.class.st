"
I display a list of editors of an object in a vertical list.

I fetch data from the diagrammer editor data source


"
Class {
	#name : #GtDiagrammerEditorList,
	#superclass : #BlInfiniteElement,
	#category : #'GToolkit-Diagrammer-UI-Lists'
}

{ #category : #initialization }
GtDiagrammerEditorList >> defaultDataSource [
	^ GtDiagrammerEditorDataSource new
]

{ #category : #initialization }
GtDiagrammerEditorList >> defaultLayout [
	^ BlInfiniteLinearLayout vertical
]

{ #category : #initialization }
GtDiagrammerEditorList >> initialize [
	super initialize
]
