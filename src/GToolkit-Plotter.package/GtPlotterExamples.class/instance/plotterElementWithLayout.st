instance creation
plotterElementWithLayout
	<gtExample>

	^ self plotterElement
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		layout: self plotterLayout