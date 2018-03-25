initialization
initializeCanvas
	canvasContainer := GtDiagrammerCard new.
	canvasContainer constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	canvasContainer background: Color white.
	
	canvas := BlElement new.
	canvas constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	canvasContainer addChild: canvas