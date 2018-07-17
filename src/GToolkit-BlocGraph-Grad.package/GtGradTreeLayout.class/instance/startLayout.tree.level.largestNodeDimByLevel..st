as yet unclassified
startLayout: aNodeElement tree: aDFSTree level: aLevel largestNodeDimByLevel: maxLevelDimsDict
	| nodeDim maxDim|
	
	GtGradTreeLayoutNodeProcessingStartedSignal new 
		node: aNodeElement;
		level: aLevel;
		emit.

	nodeDim := self nodeOffsetDim: aNodeElement.
	maxLevelDimsDict at: aLevel ifAbsentPut: [ nodeDim ].
	maxDim := maxLevelDimsDict at: aLevel.
	nodeDim > maxDim
		ifTrue: [ maxLevelDimsDict at: aLevel put: nodeDim ].

	self setOffsetsAndContours: aNodeElement
		  tree: aDFSTree
		  level: aLevel
		  largestNodeDimByLevel: maxLevelDimsDict.
		
	GtGradTreeLayoutNodeProcessingFinishedSignal new
		node: aNodeElement;
		level: aLevel;
		emit