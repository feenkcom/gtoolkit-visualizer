api - hooks
onInstalledIn: aDiagrammerElement
	super onInstalledIn: aDiagrammerElement.

	aDiagrammerElement canvas addEventHandler: selector.
	chooser := GtDiagrammerFigureChooser on: self.

	deleter := BlShortcut new
		combination: (BlKeyCombination builder meta delete build);
		action: [ self deleteSelected ].

	aDiagrammerElement canvas addEventHandler: chooser.
	aDiagrammerElement canvas addShortcut: deleter