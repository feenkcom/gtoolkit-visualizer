accessing
tool: aGtDiagrammerTool
	self removeEventHandler: self tool.
	tool := aGtDiagrammerTool.
	self addEventHandler: self tool.

	tools select: self tool.
	self tool stylesIn: styles.
	styles selectFirst