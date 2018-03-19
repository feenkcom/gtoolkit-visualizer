api - selection
selectOnly: anElement
	"Make a given element the only selected one by deselecting the rest of the elements"
	
	self deselectAll.
	self select: anElement