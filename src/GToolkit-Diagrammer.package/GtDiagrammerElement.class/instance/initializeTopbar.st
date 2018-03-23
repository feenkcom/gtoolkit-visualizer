initialization
initializeTopbar
	topbar := BlElement new.
	topbar layout: (BlLinearLayout horizontal).
	topbar clipChildren: false.
	topbar constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal matchParent ]