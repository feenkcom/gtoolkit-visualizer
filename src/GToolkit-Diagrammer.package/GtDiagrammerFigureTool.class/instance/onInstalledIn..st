api - hooks
onInstalledIn: aDiagrammerElement
	creator := BlEventHandler on: BlClickEvent do: [ :anEvent |
		| aLocation aFigureElement |
		aLocation := anEvent currentTarget globalPointToLocal: anEvent position.
		aFigureElement := aDiagrammerElement instantiate: self style at: aLocation.
		
		aDiagrammerElement select: aFigureElement.
		aDiagrammerElement edit: aFigureElement ].
	aDiagrammerElement canvas addEventHandler: creator