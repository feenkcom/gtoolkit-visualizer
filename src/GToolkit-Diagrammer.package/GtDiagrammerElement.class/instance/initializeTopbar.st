initialization
initializeTopbar
	topbar := BlElement new.
	topbar layout: (BlLinearLayout vertical).
	topbar clipChildren: false.
	topbar constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal matchParent ]