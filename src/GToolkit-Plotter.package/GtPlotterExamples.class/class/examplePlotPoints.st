examples
examplePlotPoints
	| space plot |
	
	plot := self new plot.
	plot size: 400@400.
	plot relocate: 50@50.	
	plot clipChildren: false.
	
	space := BlSpace new.
	space withHalos.
	space root addChild: plot.
	space show