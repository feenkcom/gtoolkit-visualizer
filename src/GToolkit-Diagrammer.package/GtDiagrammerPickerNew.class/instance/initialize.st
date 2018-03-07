initialization
initialize
	super initialize.
	
	displayBlock := [ #() ].	
	shapeBlock := [ BrToggle new look: BrMaterialToggleButtonLook new ].
	
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].