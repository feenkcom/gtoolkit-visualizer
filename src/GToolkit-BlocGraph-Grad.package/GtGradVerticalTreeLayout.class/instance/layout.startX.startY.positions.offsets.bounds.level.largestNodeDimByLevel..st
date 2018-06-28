calculating
layout: aNode startX: x0 startY: y0 positions: aPositionsDict offsets: anOffsetsDict bounds: bounds level: level largestNodeDimByLevel: maxLevelHeightsDict
	| nodePosition newBounds newNodePositionX newNodePositionY childrenOffsetX childrenOffsetY nodeHeight levelMaxHeight yCorrection firstChild|
	
	nodePosition := aPositionsDict at: aNode.
	nodeHeight := aNode measuredBounds height.
	levelMaxHeight := maxLevelHeightsDict at: level.
	yCorrection := (levelMaxHeight - nodeHeight)/2.

	newNodePositionX := (nodePosition x) + x0 + ((anOffsetsDict at: aNode) y).
	newNodePositionY := (nodePosition y) + y0 + ((anOffsetsDict at: aNode) x) + yCorrection.
	aPositionsDict at: aNode put: newNodePositionX@newNodePositionY.
	newBounds := self calculateBounds: aNode bounds: bounds  positions: aPositionsDict.
	
	(aNode graph connectedNodesAlongOutgoingEdges) isEmpty
		ifTrue: [ ^ newBounds ].
	
	firstChild := (aNode graph connectedNodesAlongOutgoingEdges) first.
   newBounds := self layout: firstChild
							startX: newNodePositionX
						 	startY: newNodePositionY
							positions: aPositionsDict
						   offsets: anOffsetsDict
						   bounds: newBounds
						   level: (level + 1)
						   largestNodeDimByLevel: maxLevelHeightsDict.

	childrenOffsetY := newNodePositionY + ((anOffsetsDict at: firstChild) x).
	childrenOffsetX := newNodePositionX + ((anOffsetsDict at: firstChild) y).

	(aNode graph connectedNodesAlongOutgoingEdges) do: [ :child |
		child = firstChild
			ifFalse: [  
				newBounds := self layout: child
									 	startX: childrenOffsetX
		                  		 	startY: childrenOffsetY
										positions: aPositionsDict
									   offsets: anOffsetsDict
									   bounds: newBounds
									   level: (level + 1)
									   largestNodeDimByLevel: maxLevelHeightsDict.

			childrenOffsetX := childrenOffsetX + ((anOffsetsDict at: child) y).
		].
	].

	^ newBounds.