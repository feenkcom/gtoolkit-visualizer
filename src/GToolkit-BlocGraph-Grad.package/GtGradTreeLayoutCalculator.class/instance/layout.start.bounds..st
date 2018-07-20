private - layout
layout: aTreeNode start: aStartPoint bounds: bounds
	| newBounds nodePosition newNodePositionX newNodePositionY childrenOffsetX childrenOffsetY firstChild alignmentCorrection|

	nodePosition := aTreeNode element constraints gradTree computedPosition.
	alignmentCorrection := (self layout nodeAlignmentCorrection: aTreeNode).

	GtGradTreeLayoutCorrectionSignal new 
		node: aTreeNode;
		alignmentCorrection: alignmentCorrection;
		emit.
	
	newNodePositionX := (nodePosition x) +
							  aStartPoint x +
							  (self layout nodeOffsetBreadth: aTreeNode element) +
							  alignmentCorrection x.
	newNodePositionY := (nodePosition y) +
							  aStartPoint y +
							  (self layout nodeOffsetLength: aTreeNode element) +
							  alignmentCorrection y.

	aTreeNode element constraints gradTree computedPosition: newNodePositionX@newNodePositionY.

	newBounds := self
		updateNodeBounds: aTreeNode
		bounds: bounds
		positionX: newNodePositionX
		positionY: newNodePositionY.	

	(aTreeNode nodes isEmpty)
		ifTrue: [ ^ newBounds ].

	firstChild := aTreeNode nodes first.

	newBounds := self
		layout: firstChild
		start: newNodePositionX @ newNodePositionY
		bounds: newBounds.

	childrenOffsetX := newNodePositionX + (self layout nodeOffsetBreadth: firstChild element).
	childrenOffsetY := newNodePositionY + (self layout nodeOffsetLength: firstChild element).

	aTreeNode nodes do: [ :child |
		child = firstChild
			ifFalse: [  
					newBounds := self layout: child
											start: childrenOffsetX @ childrenOffsetY
											bounds: newBounds. 

					childrenOffsetX := childrenOffsetX + (self layout childOffsetBreadth: child element).
					childrenOffsetY := childrenOffsetY + (self layout childOffsetLength: child element).
				].
		].

	^ newBounds.