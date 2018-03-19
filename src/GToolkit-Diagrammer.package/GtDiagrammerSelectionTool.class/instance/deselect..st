api - selection
deselect: anElement
	"Is sent after a given element is deselected in a diagrammer"

	self selectedFigures remove: anElement.
	self diagrammer closeEditor.

	resizer detach.
	(self canvas hasChild: resizer)
		ifTrue: [ self canvas removeChild: resizer ]