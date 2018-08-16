initialize
initialize
	super initialize.
	mondrianInstance := GtMondrian new.
	paintingStencilBuilder := [ :x | "do nothing by default" ]