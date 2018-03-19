api - hooks
onUninstalledIn: aDiagrammerElement
	super onUninstalledIn: aDiagrammerElement.

	aDiagrammerElement canvas removeEventFilter: connector