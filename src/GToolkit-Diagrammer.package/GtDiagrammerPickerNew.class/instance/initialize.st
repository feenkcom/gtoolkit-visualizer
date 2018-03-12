initialization
initialize
	super initialize.
	
	displayBlock := [ #() ].	
	shapeBlock := [ BrToggle new look: BrMaterialToggleButtonLook new ].
	
	self layout: BlLinearLayout horizontal.
	self padding: (BlInsets all: 10).
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].