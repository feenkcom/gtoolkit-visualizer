examples - composite
plot
	<gtExample>
	| plot hAxis vAxis dots |
	
	plot := self plotterElementWithLayout.
	
	hAxis := self horizontalAxis.
	hAxis constraints plotter horizontal axis valueSelector: #x.
	
	vAxis := self verticalAxis.
	vAxis constraints plotter vertical axis valueSelector: #y.
	
	dots := self dots.
	
	^ plot addChildren: { hAxis . vAxis }, dots