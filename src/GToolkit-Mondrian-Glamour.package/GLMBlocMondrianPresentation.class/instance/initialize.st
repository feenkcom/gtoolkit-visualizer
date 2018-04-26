scripting
initialize
	super initialize.
	paintingBlock := [ :aGtMondrian :theDisplayValue | ].
	viewInitializer := [ GtMondrian new ].
	self withNodeClicks.
	self withEdgeClicks