actions
select: anElement

	self deselect.
	resizer attachTo: anElement.
	self canvas addChild: resizer.

	self tool: GtDiagrammerSelectionTool new.
	anElement requestFocus