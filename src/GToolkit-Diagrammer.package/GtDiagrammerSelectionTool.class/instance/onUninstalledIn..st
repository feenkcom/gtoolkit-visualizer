api - hooks
onUninstalledIn: aDiagrammerElement
	aDiagrammerElement canvas removeEventHandler: selector.
	aDiagrammerElement canvas removeEventHandler: chooser.
	aDiagrammerElement canvas removeEventHandler: editor.
	
	aDiagrammerElement deselect.
	aDiagrammerElement closeEditor