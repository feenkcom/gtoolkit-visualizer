initialization
initializeSidebar
	sidebar := BlElement new.
	sidebar width: 300.
	sidebar layout: (BlLinearLayout vertical).
	sidebar clipChildren: false.
	sidebar constraintsDo: [ :c |
		c vertical matchParent.
		c frame horizontal alignRight ].

	sidebar
		addChild: (BlElement new
			layout: BlLinearLayout vertical;
			clipChildren: false;
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical fitContent ])
		as: #tools.
		
	sidebar
		addChild: (GtDiagrammerEditorList new
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical fitContent ])
		as: #editor