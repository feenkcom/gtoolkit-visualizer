initialization
initialize
	super initialize.
	
	displayBlock := [ #() ].
	shapeBlock := [ BlElement new ].
	selectedBlock := [  ].
	deselectedBlock := [  ].
	
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].