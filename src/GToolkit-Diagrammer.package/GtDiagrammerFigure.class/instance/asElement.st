converting
asElement
	| anElement |
	<return: #BlElement>
	
	anElement := BlElement new
		background: self background;
		border: self border;
		geometry: self geometry;
		transformation: self transformation;
		relocate: self position;
		size: self extent.

	self addEventHandler: (GtDiagrammerFigureUpdater new element: anElement).
	
	anElement addEventHandler: BlPullHandler new.
	anElement addEventHandlerOn: BlClickEvent do: [ :anEvent | BlElementSelection on: anEvent currentTarget ].

	^ anElement