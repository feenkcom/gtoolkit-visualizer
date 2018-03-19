initialization
initialize
	super initialize.

	tool := GtDiagrammerDummyTool new.

	self background: (Color gray alpha: 0.1).
	
	self layout: (BlGridLayout vertical cellSpacing: 20; rowCount: 2).
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	self initializeCanvas.
	self initializeTopbar.
	self initializeSidebar.
	self initializeTools.

	self addChildren: { topbar . canvas . sidebar }.

	"select a tool by default"
	self tool: self availableTools anyOne