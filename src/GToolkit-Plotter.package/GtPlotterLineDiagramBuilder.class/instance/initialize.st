initialization
initialize
	super initialize.
	
	axisX := BlElement new.
	axisX background: Color black.
	axisX constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: 0 ].
	axisX constraintsDo: [ :c | c plotter horizontal axis: (GtPlotterContinuousAxis new valueSelector: #yourself) ].
	
	axisY := BlElement new.
	axisY background: Color black.
	axisY constraintsDo: [ :c |
		c horizontal exact: 0.
		c vertical matchParent ].
	axisY constraintsDo: [ :c | c plotter vertical axis: (GtPlotterContinuousAxis new valueSelector: #yourself) ]