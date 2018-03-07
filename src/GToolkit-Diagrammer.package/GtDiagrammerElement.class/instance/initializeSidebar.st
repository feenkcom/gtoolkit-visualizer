initialization
initializeSidebar
	sidebar := BlElement new.
	sidebar width: 300.
	sidebar layout: (BlLinearLayout vertical).
	sidebar clipChildren: false.
	sidebar constraintsDo: [ :c |
		c vertical matchParent.
		c frame horizontal alignRight.
		c grid vertical span: 2 ].
		
	sidebar
		addChild: (GtDiagrammerEditorList new
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ])
		as: #editor