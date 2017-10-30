scripting - shape
umlClassShapeWithName: aBlock
	self shape: [ :each | 
		GtMondrianUMLClassElement withDefaultContainer 
			label: (aBlock value: each) asString ]