initialization
initialize
	super initialize.

	itemElement := GtDiagrammerTitledCard new.
	itemElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ]