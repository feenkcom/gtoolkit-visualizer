api - hooks
onUninstalledIn: aDiagrammerElement
	super onUninstalledIn: aDiagrammerElement.

	aDiagrammerElement canvas removeEventFilter: connector.
	aDiagrammerElement canvas removeEventHandler: hoverOver.
	aDiagrammerElement canvas removeEventHandler: hoverOut.
	
	overlay detach.
	overlay removeFromParent