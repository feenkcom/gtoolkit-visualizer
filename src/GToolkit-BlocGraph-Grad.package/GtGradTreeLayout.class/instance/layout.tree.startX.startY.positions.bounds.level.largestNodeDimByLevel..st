as yet unclassified
layout: aNodeElement tree: aDFSTree startX: x0 startY: y0 positions: aPositionsDict bounds: bounds level: aLevel largestNodeDimByLevel: maxaLevelDimsDict
	| newBounds nodePosition newNodePositionX newNodePositionY childrenOffsetX childrenOffsetY breadthCorrection lengthCorrection firstChild|
	
	nodePosition := aPositionsDict at: aNodeElement.
	breadthCorrection :=  self nodeBreadthCorrection: aNodeElement level: aLevel largestNodeDimByLevel: maxaLevelDimsDict.
	lengthCorrection :=  self nodeLengthCorrection: aNodeElement level: aLevel largestNodeDimByLevel: maxaLevelDimsDict.
	
	GtGradTreeLayoutCorrectionSignal new 
		node: aNodeElement; 
		breadthCorrection: breadthCorrection; 
		lengthCorrection: lengthCorrection;
		emit.
	
	newNodePositionX := (nodePosition x) + x0 + (self nodeOffsetBreadth: aNodeElement) + breadthCorrection.
	newNodePositionY := (nodePosition y) + y0 + (self nodeOffsetLength: aNodeElement) + lengthCorrection.
	aPositionsDict at: aNodeElement put: newNodePositionX@newNodePositionY.

	newBounds := self updateBounds: aNodeElement
							bounds:bounds
							positionX: newNodePositionX
							positionY: newNodePositionY.	


	(aDFSTree includesKey: aNodeElement)
		ifFalse: [ ^ newBounds ].

	firstChild := (aDFSTree at: aNodeElement) first.
	newBounds := self layout: firstChild
							tree: aDFSTree
							startX: newNodePositionX
							startY: newNodePositionY
							positions: aPositionsDict
							bounds: newBounds
							level: (aLevel + 1)
							largestNodeDimByLevel: maxaLevelDimsDict.

	childrenOffsetX := newNodePositionX + (self nodeOffsetBreadth: firstChild).
	childrenOffsetY := newNodePositionY + (self nodeOffsetLength: firstChild).

	(aDFSTree at: aNodeElement) do: [ :child |
		
		child = firstChild
			ifFalse: [  
					newBounds := self layout: child
											tree: aDFSTree
											startX: childrenOffsetX
											startY: childrenOffsetY
											positions: aPositionsDict
											bounds: newBounds
											level: (aLevel + 1)
											largestNodeDimByLevel: maxaLevelDimsDict. 

					childrenOffsetX := childrenOffsetX + (self childOffsetBreadth: child).
					childrenOffsetY := childrenOffsetY + (self childOffsetLength: child).
				].
		].

	^ newBounds.