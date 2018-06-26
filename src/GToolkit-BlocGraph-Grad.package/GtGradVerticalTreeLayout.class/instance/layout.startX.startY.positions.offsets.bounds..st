calculating
layout: aNode startX: x0 startY: y0 positions: aPositionsDict offsets: anOffsetsDict bounds: bounds
	| nodePosition newBounds newNodePositionX newNodePositionY childrenOffsetX childrenOffsetY |
	
	nodePosition := aPositionsDict at: aNode.
	newNodePositionX := (nodePosition x) + x0 + ((anOffsetsDict at: aNode) y).
	newNodePositionY := (nodePosition y) + y0 + ((anOffsetsDict at: aNode) x).
	aPositionsDict at: aNode put: newNodePositionX@newNodePositionY.
	newBounds := self calculateBounds: aNode bounds: bounds  positions: aPositionsDict.
	
	childrenOffsetX := newNodePositionX.
	childrenOffsetY := newNodePositionY.
	
	(aNode graph connectedNodesAlongOutgoingEdges) doWithIndex: [ :child  :i|
		
		newBounds := self layout: child startX: childrenOffsetX startY: childrenOffsetY positions: aPositionsDict offsets: anOffsetsDict bounds: newBounds. 
		i = 1
			ifTrue: [ 
				childrenOffsetY := childrenOffsetY + ((anOffsetsDict at: child) x).
			].

		childrenOffsetX := childrenOffsetX + ((anOffsetsDict at: child) y).
	].

	^ newBounds.