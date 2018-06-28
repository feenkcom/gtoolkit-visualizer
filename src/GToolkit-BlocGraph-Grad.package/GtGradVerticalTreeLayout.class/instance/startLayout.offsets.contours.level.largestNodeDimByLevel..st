calculating
startLayout: aNode offsets: anOffsetsDict contours: aContoursDict level: level largestNodeDimByLevel: maxLevelHeightsDict
	<return: #Collection of: #Point>
	| nodeHeight maxHeight |
	nodeHeight := aNode measuredBounds height.
	maxLevelHeightsDict at: level ifAbsentPut: [ nodeHeight ].
	maxHeight := maxLevelHeightsDict at: level.
	nodeHeight > maxHeight
		ifTrue: [ maxLevelHeightsDict at: level put: nodeHeight ].
	self setOffsetsAndContours: aNode
		  offsets: anOffsetsDict
		  contours: aContoursDict
		  level: level
		  largestNodeDimByLevel: maxLevelHeightsDict