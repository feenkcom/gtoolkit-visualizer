api - selection
deselect: anElement
	"Is sent after a given element is deselected in a diagrammer"

	self selectedFigures remove: anElement.
	self diagrammer closeEditor.

	chooser resetCurrentSelection.

	resizer detach.
	(self canvas hasChild: resizer)
		ifTrue: [ self canvas removeChild: resizer ]