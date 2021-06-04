"
I am a selection tool and responsible for all actions and operations in a selection mode.

Those operations consist of:

 - selection / deselection
 - deletion


"
Class {
	#name : #GtDiagrammerSelectionTool,
	#superclass : #GtDiagrammerTool,
	#instVars : [
		'selector',
		'chooser',
		'deleter',
		'selectedFigures',
		'resizer'
	],
	#category : #'GToolkit-Diagrammer-Tools - Selection'
}

{ #category : #'api - deletion' }
GtDiagrammerSelectionTool >> deleteSelected [
	"Delete all selected figures from a diagrammer"
	
	self selectedFigures copy do: [ :anElement |
		self deselect: anElement.
		anElement removeFromParent ]
]

{ #category : #'api - selection' }
GtDiagrammerSelectionTool >> deselect: anElement [
	"Is sent after a given element is deselected in a diagrammer"

	self selectedFigures remove: anElement.
	self diagrammer closeEditor.

	chooser resetCurrentSelection.

	resizer detach.
	(self canvas hasChild: resizer)
		ifTrue: [ self canvas removeChild: resizer ]
]

{ #category : #'api - selection' }
GtDiagrammerSelectionTool >> deselectAll [
	"Deselect all selected figures"

	self selectedFigures copy do: [ :anElement | self deselect: anElement ]
]

{ #category : #initialization }
GtDiagrammerSelectionTool >> initialize [
	super initialize.
	
	selector := BlVisualSelectionHandler new.

	selectedFigures := Set new.

	resizer := BlResizerElement new.
	resizer preventMouseEvents
]

{ #category : #'api - testing' }
GtDiagrammerSelectionTool >> isSelected: anElement [
	<return: #Boolean>

	^ self selectedFigures includes: anElement
]

{ #category : #'api - hooks' }
GtDiagrammerSelectionTool >> onInstalledIn: aDiagrammerElement [
	super onInstalledIn: aDiagrammerElement.

	"aDiagrammerElement canvas addEventHandler: selector."
	chooser := GtDiagrammerSelectionChooser on: self.

	deleter := BlShortcutWithAction new
		combination: (BlKeyCombination builder primary delete build);
		action: [ self deleteSelected ].

	aDiagrammerElement canvas addEventHandler: chooser.
	aDiagrammerElement canvas addShortcut: deleter
]

{ #category : #'api - hooks' }
GtDiagrammerSelectionTool >> onUninstalledIn: aDiagrammerElement [
	super onUninstalledIn: aDiagrammerElement.

	"aDiagrammerElement canvas removeEventHandler: selector."
	aDiagrammerElement canvas removeEventHandler: chooser.
	aDiagrammerElement canvas removeShortcut: deleter.

	self deselectAll
]

{ #category : #'api - selection' }
GtDiagrammerSelectionTool >> select: anElement [
	"Additionally select a given element.
	Note: I don't deselect already selected figures"

	self selectedFigures add: anElement.

	chooser currentSelection: anElement.

	resizer attachTo: anElement.
	resizer hasParent
		ifFalse: [ self canvas addChild: resizer ].

	self diagrammer edit: anElement.	
	
	anElement requestFocus
]

{ #category : #'api - selection' }
GtDiagrammerSelectionTool >> selectOnly: anElement [
	"Make a given element the only selected one by deselecting the rest of the elements"

	(self selectedFigures size = 1
		and: [ self isSelected: anElement ])
			ifTrue: [ ^ self ].

	self deselectAll.
	self select: anElement
]

{ #category : #accessing }
GtDiagrammerSelectionTool >> selectedFigures [
	<return: #Collection of: #BlElement>

	^ selectedFigures
]

{ #category : #accessing }
GtDiagrammerSelectionTool >> symbol [
	^ 'Select'
]
