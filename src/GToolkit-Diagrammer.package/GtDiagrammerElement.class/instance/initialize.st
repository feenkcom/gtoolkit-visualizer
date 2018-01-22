initialization
initialize
	super initialize.

	tool := GtDiagrammerDummyTool new.
	
	self layout: (BlGridLayout new columnCount: 2; cellSpacing: 2).
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	header := BlElement new.
	header layout: BlLinearLayout vertical.
	header constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent.
		c grid horizontal span: 2 ].
	header background: (Color gray alpha: 0.2).
	
	tools := GtDiagrammerToolPicker new.
	tools display: [ self availableTools ].
	tools constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	tools when: GtDiagrammerPickerSelected do: [ :anEvent | self tool: anEvent entity ].

	styles := GtDiagrammerPicker new.
	styles shape: [ :aStyle | BlElement new size: 20@20; background: Color random ].
	styles constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	styles when: GtDiagrammerPickerSelected do: [ :anEvent | self tool style: anEvent entity ].

	header addChildren: { tools . styles }.	

	canvas := BlElement new.
	canvas constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	canvas background: Color white.
	
	editor := BlElement new.
	editor layout: BlLinearLayout vertical.
	editor constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical matchParent ].
	editor background: (Color gray alpha: 0.2).
		
	self addChildren: { header . canvas . editor }.
	
	self initializeTool