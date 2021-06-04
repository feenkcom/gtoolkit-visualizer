"
I am a data source for the diagrammer editor list


"
Class {
	#name : #GtDiagrammerEditorDataSource,
	#superclass : #BlInfiniteDataSource,
	#instVars : [
		'editors'
	],
	#category : #'GToolkit-Diagrammer-UI-Lists'
}

{ #category : #accessing }
GtDiagrammerEditorDataSource >> editors [
	<return: #Collection of: #GtDiagrammerFigureEditor>

	^ editors
]

{ #category : #accessing }
GtDiagrammerEditorDataSource >> editors: aCollectionOfEditors [
	editors := aCollectionOfEditors.
	editors do: [ :anEditor | anEditor changedSend: #onEditorChanged: to: self ].
	
	self notifyChanged
]

{ #category : #initialization }
GtDiagrammerEditorDataSource >> initialize [
	super initialize.
	
	editors := #()
]

{ #category : #accessing }
GtDiagrammerEditorDataSource >> itemCount [
	^ editors size
]

{ #category : #'instance creation' }
GtDiagrammerEditorDataSource >> onBindHolder: anElementHolder at: aPosition [
	anElementHolder editor: (self editors at: aPosition)
]

{ #category : #'instance creation' }
GtDiagrammerEditorDataSource >> onCreateHolder: anInfiniteElement type: anItemType [
	^ GtDiagrammerEditorCardHolder new
]

{ #category : #'event handling' }
GtDiagrammerEditorDataSource >> onEditorChanged: anAnnouncement [
	| anEditor anEditorIndex |
	
	anEditor := anAnnouncement editor.
	anEditorIndex := self editors
		indexOf: anEditor
		ifAbsent: [ ^ self ].

	self notifyItemsChanged: (anEditorIndex to: anEditorIndex)
]
