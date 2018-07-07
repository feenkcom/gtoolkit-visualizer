calculating
layout: aNode startX: x0 startY: y0 positions: aPositionsDict offsets: anOffsetsDict bounds: bounds level: level largestNodeDimByLevel: maxLevelWidthsDict
	| newBounds nodePosition newNodePositionX newNodePositionY childrenOffsetX childrenOffsetY nodeWidth levelMaxWidth breadthCorrection lengthCorrection firstChild|
	
	nodePosition := aPositionsDict at: aNode.
	nodeWidth := aNode measuredBounds width.
	levelMaxWidth := maxLevelWidthsDict at: level.
	breadthCorrection :=  self nodeBreadthCorrection: aNode level: level largestNodeDimByLevel: maxLevelWidthsDict.
	lengthCorrection :=  self nodeLengthCorrection: aNode level: level largestNodeDimByLevel: maxLevelWidthsDict.
	
	newNodePositionX := (nodePosition x) + x0 + (self nodeOffsetBreadth: aNode offsets: anOffsetsDict) + breadthCorrection.
	newNodePositionY := (nodePosition y) + y0 + (self nodeOffsetLength: aNode offsets: anOffsetsDict) + lengthCorrection.
	aPositionsDict at: aNode put: newNodePositionX@newNodePositionY.

	newBounds := self calculateBounds: aNode bounds: bounds positions: aPositionsDict.

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

	childrenOffsetX := newNodePositionX + (self nodeOffsetBreadth: firstChild offsets: anOffsetsDict).
	childrenOffsetY := newNodePositionY + (self nodeOffsetLength: firstChild offsets: anOffsetsDict)..

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

					childrenOffsetX := childrenOffsetX + (self childOffsetBreadth: child offsets: anOffsetsDict).
					childrenOffsetY := childrenOffsetY + (self childOffsetLength: child offsets: anOffsetsDict).
				].
		].

	^ newBounds.