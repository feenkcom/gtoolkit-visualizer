calculating
layout: aNode startX: x0 startY: y0 positions: aPositionsDict offsets: anOffsetsDict bounds: bounds level: level largestNodeDimByLevel: maxLevelWidthsDict
	| newBounds nodePosition newNodePositionX newNodePositionY childrenOffsetX childrenOffsetY nodeWidth levelMaxWidth xCorrection firstChild|
	
	nodePosition := aPositionsDict at: aNode.
	nodeWidth := aNode measuredBounds width.
	levelMaxWidth := maxLevelWidthsDict at: level.
	xCorrection := (levelMaxWidth - nodeWidth)/2.
	
	newNodePositionX := (nodePosition x) + x0 + ((anOffsetsDict at: aNode) x) + xCorrection.
	newNodePositionY := (nodePosition y) + y0 + ((anOffsetsDict at: aNode) y).
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
							largestNodeDimByLevel: maxLevelWidthsDict. 

	childrenOffsetX := newNodePositionX + ((anOffsetsDict at: firstChild) x).
	childrenOffsetY := newNodePositionY + ((anOffsetsDict at: firstChild) y).

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
											largestNodeDimByLevel: maxLevelWidthsDict. 

					childrenOffsetY := childrenOffsetY + ((anOffsetsDict at: child) y).
				].
		].

	^ newBounds.