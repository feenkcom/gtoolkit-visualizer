api - hooks
onInstalledIn: aDiagrammerElement
	creator := BlEventHandler on: BlClickEvent do: [ :anEvent |
		| aLocation |
		aLocation := anEvent currentTarget globalPointToLocal: anEvent position.
		aDiagrammerElement instantiate: self style at: aLocation ].
	aDiagrammerElement canvas addEventHandler: creator