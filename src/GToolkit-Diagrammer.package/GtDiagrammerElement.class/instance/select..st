api - selection
select: anElement

	"selection is only possible when corresponding tool is activated"	
	self tool: GtDiagrammerSelectionTool new.
	self tool select: anElement