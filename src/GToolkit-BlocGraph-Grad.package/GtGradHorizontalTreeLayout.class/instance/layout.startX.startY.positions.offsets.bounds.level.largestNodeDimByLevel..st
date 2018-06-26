calculating
layout: aNode startX: x0 startY: y0 positions: aPositionsDict offsets: anOffsetsDict bounds: bounds level: level largestNodeDimByLevel: maxLevelWidthsDict
	| newBounds nodePosition newNodePositionX newNodePositionY childrenOffsetX childrenOffsetY nodeWidth levelMaxWidth xCorrection|
	
	nodePosition := aPositionsDict at: aNode.
	nodeWidth := aNode measuredBounds width.
	levelMaxWidth := maxLevelWidthsDict at: level.
	xCorrection := (levelMaxWidth - nodeWidth)/2.
	
	newNodePositionX := (nodePosition x) + x0 + ((anOffsetsDict at: aNode) x) + xCorrection.
	newNodePositionY := (nodePosition y) + y0 + ((anOffsetsDict at: aNode) y).
	aPositionsDict at: aNode put: newNodePositionX@newNodePositionY.
	newBounds := self calculateBounds: aNode bounds: bounds  positions: aPositionsDict.

	childrenOffsetX := newNodePositionX.
	childrenOffsetY := newNodePositionY.
	
	(aNode graph connectedNodesAlongOutgoingEdges) doWithIndex: [ :child  :i|
		
		newBounds := self layout: child startX: childrenOffsetX startY: childrenOffsetY positions: aPositionsDict offsets: anOffsetsDict bounds: newBounds level: (level + 1) largestNodeDimByLevel: maxLevelWidthsDict. 
		i = 1
			ifTrue: [ 
				childrenOffsetX := childrenOffsetX + ((anOffsetsDict at: child) x).
			].

		childrenOffsetY := childrenOffsetY + ((anOffsetsDict at: child) y).
	].

	^ newBounds.