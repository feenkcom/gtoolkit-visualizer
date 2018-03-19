api - selection
selectOnly: anElement
	"Make a given element the only selected one by deselecting the rest of the elements"

	(self selectedFigures size = 1
		and: [ self isSelected: anElement ])
			ifTrue: [ ^ self ].

	self deselectAll.
	self select: anElement