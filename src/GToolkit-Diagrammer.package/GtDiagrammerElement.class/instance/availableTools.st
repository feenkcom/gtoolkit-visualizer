initialization
availableTools
	^ availableTools ifNil: [ availableTools := {
		GtDiagrammerSelectionTool new.
		GtDiagrammerFigureTool new.
		GtDiagrammerLineTool new } ]