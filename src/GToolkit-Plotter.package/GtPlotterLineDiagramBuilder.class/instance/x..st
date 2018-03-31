api - scripting
x: aBlock
	axisX constraintsDo: [ :c | c plotter horizontal axis: (GtPlotterContinuousAxis new valueSelector: aBlock) ]