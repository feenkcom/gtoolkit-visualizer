calculating
layout: aNodeElement tree: aDFSTree startX: x0 startY: y0 positions: aPositionsDict offsets: anOffsetsDict bounds: bounds level: aLevel largestNodeDimByLevel: maxaLevelDimsDict
	| newBounds nodePosition newNodePositionX newNodePositionY childrenOffsetX childrenOffsetY breadthCorrection lengthCorrection firstChild|
	
	nodePosition := aPositionsDict at: aNodeElement.
	breadthCorrection :=  self nodeBreadthCorrection: aNodeElement level: aLevel largestNodeDimByLevel: maxaLevelDimsDict.
	lengthCorrection :=  self nodeLengthCorrection: aNodeElement level: aLevel largestNodeDimByLevel: maxaLevelDimsDict.
	
	GtGradTreeLayoutCorrectionSignal new 
		node: aNodeElement; 
		breadthCorrection: breadthCorrection; 
		lengthCorrection: lengthCorrection;
		emit.
	
	newNodePositionX := (nodePosition x) + x0 + (self nodeOffsetBreadth: aNodeElement offsets: anOffsetsDict) + breadthCorrection.
	newNodePositionY := (nodePosition y) + y0 + (self nodeOffsetLength: aNodeElement offsets: anOffsetsDict) + lengthCorrection.
	aPositionsDict at: aNodeElement put: newNodePositionX@newNodePositionY.

	newBounds := self calculateBounds: aNodeElement bounds: bounds positions: aPositionsDict.

	(aNodeElement graph connectedNodesAlongOutgoingEdges) isEmpty
		ifTrue: [ ^ newBounds ].

	firstChild := (aNodeElement graph connectedNodesAlongOutgoingEdges) first.
	newBounds := self layout: firstChild
							tree: aDFSTree
							startX: newNodePositionX
							startY: newNodePositionY
							positions: aPositionsDict
							offsets: anOffsetsDict
							bounds: newBounds
							level: (aLevel + 1)
							largestNodeDimByLevel: maxaLevelDimsDict. 

	childrenOffsetX := newNodePositionX + (self nodeOffsetBreadth: firstChild offsets: anOffsetsDict).
	childrenOffsetY := newNodePositionY + (self nodeOffsetLength: firstChild offsets: anOffsetsDict).

	(aDFSTree at: aNodeElement) do: [ :child |
		
		child = firstChild
			ifFalse: [  
					newBounds := self layout: child
											tree: aDFSTree
											startX: childrenOffsetX
											startY: childrenOffsetY
											positions: aPositionsDict
											offsets: anOffsetsDict
											bounds: newBounds
											level: (aLevel + 1)
											largestNodeDimByLevel: maxaLevelDimsDict. 

					childrenOffsetX := childrenOffsetX + (self childOffsetBreadth: child offsets: anOffsetsDict).
					childrenOffsetY := childrenOffsetY + (self childOffsetLength: child offsets: anOffsetsDict).
				].
		].

	^ newBounds.