calculating
startLayout: aNode offsets: anOffsetsDict contours: aContoursDict level: level largestNodeDimByLevel: maxLevelDimsDict
	| nodeDim maxDim|
	
	nodeDim := self nodeOffsetDim: aNode.
	maxLevelDimsDict at: level ifAbsentPut: [ nodeDim ].
	maxDim := maxLevelDimsDict at: level.
	nodeDim > maxDim
		ifTrue: [ maxLevelDimsDict at: level put: nodeDim ].
		
	self setOffsetsAndContours: aNode
	 	  offsets: anOffsetsDict
		  contours: aContoursDict
		  level: level
		  largestNodeDimByLevel: maxLevelDimsDict