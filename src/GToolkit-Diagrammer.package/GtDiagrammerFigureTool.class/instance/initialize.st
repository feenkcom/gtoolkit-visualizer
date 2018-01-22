initialization
initialize
	super initialize.
	
	styles := GtDiagrammerStencil allSubclasses collect: #new.
	self style: styles anyOne