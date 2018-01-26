initialization
initializeCanvas
	canvas := GtDiagrammerCard new.
	canvas constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	canvas background: Color white