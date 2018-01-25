initialization
initializeCanvas
	canvas := BlElement new.
	canvas constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	canvas background: Color white