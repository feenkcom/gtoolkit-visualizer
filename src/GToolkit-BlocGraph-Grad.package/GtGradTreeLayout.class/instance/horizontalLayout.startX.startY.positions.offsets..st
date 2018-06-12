calculating
horizontalLayout: aNode startX: x0 startY: y0 positions: aPositionsDict offsets: anOffsetsDict
	| nodePosition newNodePositionX newNodePositionY childrenOffsetX childrenOffsetY |
	
	nodePosition := aPositionsDict at: aNode.
	newNodePositionX := (nodePosition x) + x0 + ((anOffsetsDict at: aNode) x).
	newNodePositionY := (nodePosition y) + y0 + ((anOffsetsDict at: aNode) y).
	aPositionsDict at: aNode put: newNodePositionX@newNodePositionY.

	childrenOffsetX := newNodePositionX.
	childrenOffsetY := newNodePositionY.
	
	(self childrenNodes: aNode) doWithIndex: [ :child  :i|
		
		self horizontalLayout: child startX: childrenOffsetX startY: childrenOffsetY positions: aPositionsDict offsets: anOffsetsDict. 
		i = 1
			ifTrue: [ 
				childrenOffsetX := childrenOffsetX + ((anOffsetsDict at: child) x).
			].

		childrenOffsetY := childrenOffsetY + ((anOffsetsDict at: child) y).
	].

