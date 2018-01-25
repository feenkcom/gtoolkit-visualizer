initialization
initializeSidebar
	sidebar := BlElement new.
	sidebar width: 300.
	sidebar layout: (BlLinearLayout vertical).
	sidebar constraintsDo: [ :c |
		c vertical matchParent.
		c frame horizontal alignRight ].
	"sidebar background: (Color gray alpha: 0.1)."
	
	sidebar
		addChild: (BlElement new
			layout: (BlLinearLayout vertical);
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical fitContent ])
		as: #tools.
		
	sidebar
		addChild: (BlElement new
			layout: (BlLinearLayout vertical);
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical fitContent ])
		as: #editor