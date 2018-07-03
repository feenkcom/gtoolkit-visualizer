calculating
startLayout: aNode offsets: anOffsetsDict contours: aContoursDict level: level largestNodeDimByLevel: maxLevelWidthsDict
	| nodeWidth maxWidth|
	
	nodeWidth := aNode measuredBounds width.
	maxLevelWidthsDict at: level ifAbsentPut: [ nodeWidth ].
	maxWidth := maxLevelWidthsDict at: level.
	nodeWidth > maxWidth
		ifTrue: [ maxLevelWidthsDict at: level put: nodeWidth ].
		
	self setOffsetsAndContours: aNode
	 	  offsets: anOffsetsDict
		  contours: aContoursDict
		  level: level
		  largestNodeDimByLevel: maxLevelWidthsDict