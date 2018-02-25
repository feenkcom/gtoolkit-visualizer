api - hooks
onInstalledIn: aDiagrammerElement

	aDiagrammerElement canvas addEventHandler: selector.
	
	chooser := GtDiagrammerFigureChooser on: aDiagrammerElement.
	aDiagrammerElement canvas addEventHandler: chooser