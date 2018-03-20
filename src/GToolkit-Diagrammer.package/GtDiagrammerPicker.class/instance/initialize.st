initialization
initialize
	super initialize.
	
	entities := #().
	displayBlock := [ #() ].	
	shapeBlock := [ BrToggle new look: BrMaterialToggleLabelledLook new ].
	
	self layout: BlFlowLayout horizontal.
	self padding: (BlInsets all: 10).
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].