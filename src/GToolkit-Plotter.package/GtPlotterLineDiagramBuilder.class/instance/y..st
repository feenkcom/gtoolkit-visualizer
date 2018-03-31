api - scripting
y: aBlock
	axisY constraintsDo: [ :c | c plotter vertical axis: (GtPlotterContinuousAxis new valueSelector: aBlock) ]