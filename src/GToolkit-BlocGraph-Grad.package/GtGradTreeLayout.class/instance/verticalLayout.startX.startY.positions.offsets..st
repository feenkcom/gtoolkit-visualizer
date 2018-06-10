calculating
verticalLayout: aNode startX: x0 startY: y0 positions: aPositionsDict offsets: anOffsetsDict
	| nodePosition newNodePositionX newNodePositionY childrenOffsetX childrenOffsetY |
	
	nodePosition := aPositionsDict at: aNode.
	newNodePositionX := (nodePosition x) + x0 + ((anOffsetsDict at: aNode) y).
	newNodePositionY := (nodePosition y) + y0 + ((anOffsetsDict at: aNode) x).
	aPositionsDict at: aNode put: newNodePositionX@newNodePositionY.

	childrenOffsetX := newNodePositionX.
	childrenOffsetY := newNodePositionY.
	
	(self childrenNodes: aNode) doWithIndex: [ :child  :i|
		
		self verticalLayout: child startX: childrenOffsetX startY: childrenOffsetY positions: aPositionsDict offsets: anOffsetsDict. 
		i = 1
			ifTrue: [ 
				childrenOffsetX := childrenOffsetX + ((anOffsetsDict at: child) y).
			].
		childrenOffsetY := childrenOffsetY + ((anOffsetsDict at: child) x).
	].

