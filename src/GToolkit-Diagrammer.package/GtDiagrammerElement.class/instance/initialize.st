initialization
initialize
	super initialize.

	tool := GtDiagrammerDummyTool new.

	self background: (Color gray alpha: 0.1).
	
	self layout: (BlGridLayout new cellSpacing: 20; columnCount: 2).
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	self initializeCanvas.
	self initializeTopbar.
	self initializeSidebar.
	self initializeTools.
	self initializeExports.

	self addChildren: { topbar . sidebar . canvas }.

	"select a tool by default"
	self tool: self availableTools anyOne