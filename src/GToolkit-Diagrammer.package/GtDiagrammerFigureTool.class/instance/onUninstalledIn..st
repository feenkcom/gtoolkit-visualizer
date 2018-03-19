api - hooks
onUninstalledIn: aDiagrammerElement
	super onUninstalledIn: aDiagrammerElement.

	aDiagrammerElement canvas removeEventHandler: creator