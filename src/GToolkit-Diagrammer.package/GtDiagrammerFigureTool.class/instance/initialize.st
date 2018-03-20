initialization
initialize
	super initialize.

	styles := GtDiagrammerElementStencil allSubclasses collect: #new.
	
	overlay := BlOverlayElement new.
	overlay border: (BlBorder paint: (Color blue alpha: 0.1) width: 5).
	overlay clipChildren: false.

	self style: styles anyOne