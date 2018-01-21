accessing
background: aBlBackground
	background := aBlBackground.
	
	self dispatchEvent: (GtDiagrammerChangeBackground new background: background)