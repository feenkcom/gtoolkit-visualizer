initialization
initialize
	super initialize.

	tool := GtDiagrammerDummyTool new.
	
	self layout: (BlGridLayout horizontal cellSpacing: 20).
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	self initializeCanvas.
	self initializeResizer.
	self initializeSidebar.
	self initializeTools.
		
	self addChildren: { canvas . sidebar }.
	
	"select a tool by default"
	self tool: self availableTools anyOne