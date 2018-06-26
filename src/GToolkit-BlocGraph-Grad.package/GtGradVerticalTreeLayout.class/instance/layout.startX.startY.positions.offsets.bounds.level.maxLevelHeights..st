calculating
layout: aNode startX: x0 startY: y0 positions: aPositionsDict offsets: anOffsetsDict bounds: bounds level: level maxLevelHeights: maxLevelHeightsDict
	| nodePosition newBounds newNodePositionX newNodePositionY childrenOffsetX childrenOffsetY nodeHeight levelMaxHeight yCorrection|
	
	nodePosition := aPositionsDict at: aNode.
	nodeHeight := aNode measuredBounds height.
	levelMaxHeight := maxLevelHeightsDict at: level.
	yCorrection := (levelMaxHeight - nodeHeight)/2.

	newNodePositionX := (nodePosition x) + x0 + ((anOffsetsDict at: aNode) y).
	newNodePositionY := (nodePosition y) + y0 + ((anOffsetsDict at: aNode) x) + yCorrection.
	aPositionsDict at: aNode put: newNodePositionX@newNodePositionY.
	newBounds := self calculateBounds: aNode bounds: bounds  positions: aPositionsDict.
	
	childrenOffsetX := newNodePositionX.
	childrenOffsetY := newNodePositionY.
	
	(aNode graph connectedNodesAlongOutgoingEdges) doWithIndex: [ :child  :i|
		
		newBounds := self layout: child startX: childrenOffsetX startY: childrenOffsetY positions: aPositionsDict offsets: anOffsetsDict bounds: newBounds level: (level + 1) maxLevelHeights: maxLevelHeightsDict. 
		i = 1
			ifTrue: [ 
				childrenOffsetY := childrenOffsetY + ((anOffsetsDict at: child) x).
			].

		childrenOffsetX := childrenOffsetX + ((anOffsetsDict at: child) y).
	].

	^ newBounds.