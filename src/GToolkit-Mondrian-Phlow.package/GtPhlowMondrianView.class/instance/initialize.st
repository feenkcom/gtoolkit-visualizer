initialize
initialize
	super initialize.
	mondrianInstance := GtMondrian new.
	paintingStencilBuilder := [ :x | "do nothing by default" ].
	self actionStencil: [ 
		BrButton new 
			look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
			icon: BrGlamorousIcons zoomin asElement ;
			action: [ mondrianElement zoomIn ] ].
	self actionStencil: [ 
		BrButton new 
			look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
			icon: BrGlamorousIcons zoomout asElement ;
			action: [ mondrianElement zoomOut ] ].
	self actionStencil: [ 
		BrButton new 
			look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
			icon: BrGlamorousIcons zoomtofit asElement ;
			action: [ mondrianElement zoomToFit ] ].
	self actionStencil: [ 
		BrButton new
			look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
			icon: BrGlamorousIcons actualsize asElement;
			action: [ mondrianElement zoomToActualSize ] ]
	