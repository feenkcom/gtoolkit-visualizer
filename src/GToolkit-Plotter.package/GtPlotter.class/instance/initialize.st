initialization
initialize
	stack := Stack new.
	
	stack push: (GtPlotterStep new 
		root: ((BlElement new
			layout: GtPlotterLayout new;
			clipChildren: false;
			constraintsDo: [ :constraints |
				constraints horizontal matchParent.
				constraints vertical matchParent ];
			background: (BlBackground paint: Color white);
			zIndex: 1)))