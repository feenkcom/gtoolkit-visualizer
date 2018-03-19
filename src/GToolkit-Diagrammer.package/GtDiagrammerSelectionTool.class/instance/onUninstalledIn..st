api - hooks
onUninstalledIn: aDiagrammerElement
	aDiagrammerElement canvas removeEventHandler: selector.
	aDiagrammerElement canvas removeEventHandler: chooser.
	
	aDiagrammerElement deselect.
	aDiagrammerElement closeEditor.
	
	aDiagrammerElement canvas removeShortcut: deleter.