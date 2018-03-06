initialization
initialize
	super initialize.
	
	self clipChildren: false.
	self initializeEditor.
	self size: 200@100.
	self border: (BlBorder paint: Color black width: 1).
	self background: Color white.