api - hooks
onInstalledIn: aDiagrammerElement

	aDiagrammerElement canvas addEventHandler: selector.

	chooser := GtDiagrammerFigureChooser on: aDiagrammerElement.

	deleter := BlShortcut new
		combination: (BlKeyCombination builder meta delete build);
		action: [ self inform: 'delete' ].

	aDiagrammerElement canvas addEventHandler: chooser.
	aDiagrammerElement canvas addShortcut: deleter.