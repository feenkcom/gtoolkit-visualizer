api - selection
select: anElement

	self currentSelection = anElement
		ifTrue: [ ^ self ].

	self selectionTool selectOnly: anElement.
	currentSelection := anElement