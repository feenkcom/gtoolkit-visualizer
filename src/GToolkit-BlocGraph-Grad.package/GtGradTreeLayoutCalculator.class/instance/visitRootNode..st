visiting
"protocol: #visiting"

visitRootNode: aTreeNode
	| bounds dx dy |

	GtGradProcessingTreeSignal new
		root: aTreeNode;
		emit.

	bounds := BlBounds new.
	bounds left: SmallInteger maxVal.
	bounds top: SmallInteger maxVal.
	self
		layout: aTreeNode
		currentNode: aTreeNode
		start: self origin
		bounds: bounds.

	dx := (self origin x) - (bounds left).
	dy := (self origin y) - (bounds top).
	
	self reverse
		ifTrue: [ 
			self reverse: aTreeNode
			     rootPosition: (aTreeNode element constraints gradTree computedPosition)
			     bounds: bounds
		].
	
	(dx > 0 or: [ dy > 0 ])
		ifTrue: [
			self moveNode: aTreeNode dx: dx dy: dy.
	 ].

	self origin: (self layout calculateTreeStart: bounds
									  nodesXCorrection: dx
									  nodesYCorrection: dy
									  startX: self origin x
									  startY: self origin y).

