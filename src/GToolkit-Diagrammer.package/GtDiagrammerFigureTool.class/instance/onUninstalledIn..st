api - hooks
onUninstalledIn: aDiagrammerElement
	super onUninstalledIn: aDiagrammerElement.

	aDiagrammerElement canvas removeEventHandler: creator.
	aDiagrammerElement canvas removeEventHandler: hoverOver.
	aDiagrammerElement canvas removeEventHandler: hoverOut.
	
	overlay detach.
	overlay removeFromParent