layout
measurePositions: anElement with: anExtentSpec
	
	self applyOn: (anElement children select: [ :aChild | aChild constraints ignoredByLayout not ])