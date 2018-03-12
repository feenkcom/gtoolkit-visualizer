initialization
initialize
	super initialize.
	
	displayBlock := [ #() ].	
	shapeBlock := [ BrToggle new look: BrMaterialToggleButtonLook new ].
	
	self layout: BlLinearLayout horizontal.
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].