initialization
initialize
	super initialize.
	
	styles := GtDiagrammerElementStencil allSubclasses collect: #new.
	self style: styles anyOne