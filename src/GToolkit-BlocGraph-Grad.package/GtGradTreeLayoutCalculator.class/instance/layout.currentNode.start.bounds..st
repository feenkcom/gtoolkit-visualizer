private - layout
layout: aRootNode currentNode: aTreeNode start: aStartPoint bounds: bounds
	|  nodePosition newNodePositionX newNodePositionY childrenOffsetX childrenOffsetY firstChild alignmentCorrection |
	nodePosition := aTreeNode element constraints gradTree
		computedPosition.
	alignmentCorrection := self layout nodesAlignment
		calculateCorrectionFor: aTreeNode
		aRootNode: aRootNode
		layout: layout.
	GtGradTreeLayoutCorrectionSignal new
		node: aTreeNode;
		alignmentCorrection: alignmentCorrection;
		emit.
	newNodePositionX := nodePosition x + aStartPoint x
		+ (self layout nodeOffsetBreadth: aTreeNode element)
		+ alignmentCorrection x.
	newNodePositionY := nodePosition y + aStartPoint y
		+ (self layout nodeOffsetLength: aTreeNode element)
		+ alignmentCorrection y.
	aTreeNode element constraints gradTree
		computedPosition: newNodePositionX @ newNodePositionY.
	self
		updateNodeBounds: aTreeNode
		bounds: bounds
		positionX: newNodePositionX
		positionY: newNodePositionY.
	aTreeNode nodes isNotEmpty
		ifFalse: [ ^ self ].
	firstChild := aTreeNode nodes first.
	self
		layout: aTreeNode
		currentNode: firstChild
		start: newNodePositionX @ newNodePositionY
		bounds: bounds.
	childrenOffsetX := newNodePositionX
		+ (self layout nodeOffsetBreadth: firstChild element).
	childrenOffsetY := newNodePositionY
		+ (self layout nodeOffsetLength: firstChild element).
	aTreeNode nodes
		do: [ :child | 
			child = firstChild
				ifFalse: [ self
							layout: aRootNode
							currentNode: child
							start: childrenOffsetX @ childrenOffsetY
							bounds: bounds.
					childrenOffsetX := childrenOffsetX
						+ (self layout childOffsetBreadth: child element).
					childrenOffsetY := childrenOffsetY
						+ (self layout childOffsetLength: child element) ] ]