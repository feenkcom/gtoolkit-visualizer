api - hooks
onInstalledIn: aDiagrammerElement
	creator := BlEventHandler on: BlClickEvent do: [ :anEvent |
		| aLocation aFigureElement |
		
		"`anEvent currentTarget` is already a canvas"
		aLocation := anEvent currentTarget globalPointToLocal: anEvent position.

		aFigureElement := self
			instantiate: self style
			at: aLocation
			in: aDiagrammerElement canvas.

		self onInstantiated: aFigureElement in: aDiagrammerElement ].

	aDiagrammerElement canvas addEventHandler: creator