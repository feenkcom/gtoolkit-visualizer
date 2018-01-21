initialization
initialize
	super initialize.
	
	self layout: (BlGridLayout new columnCount: 2; cellSpacing: 2).
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	picker := GtDiagrammerStencilPicker new.
	picker constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent.
		c grid horizontal span: 2 ].
	picker background: (Color gray alpha: 0.2).
	
	canvas := BlElement new.
	canvas constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	canvas background: Color white.
	
	editor := BlElement new.
	editor constraintsDo: [ :c |
		c horizontal exact: 200.
		c vertical matchParent ].
	editor background: (Color gray alpha: 0.2).
	
	picker
		addEventHandlerOn: GtDiagrammerPickerSelected
		do: [ :anEvent |
			| anElement |
			anElement := anEvent entity create.
			anElement addEventHandler: BlPullHandler new.
			canvas addChild: anElement ].
	
	self addChildren: { picker . canvas . editor }