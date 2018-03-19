api - hooks
onUninstalledIn: aDiagrammerElement
	super onUninstalledIn: aDiagrammerElement.

	"aDiagrammerElement canvas removeEventHandler: selector."
	aDiagrammerElement canvas removeEventHandler: chooser.
	aDiagrammerElement canvas removeShortcut: deleter.

	self deselectAll