visiting
"protocol: #visiting"

visitRootNode: aTreeNode
	| bounds dx dy originX |

	GtGradProcessingTreeSignal new
		root: aTreeNode;
		emit.

	bounds := BlBounds new.
	bounds left: SmallInteger maxVal.
	self
		layout: aTreeNode
		currentNode: aTreeNode
		start: self origin
		bounds: bounds.

	dx := (self origin x) - (bounds left).
	dy := (self origin y) - (bounds bottom).
	
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

	
	originX := bounds right + self treesDistance.
	dx > 0
		ifTrue: [ originX := originX + dx ].

	self origin: originX @ (self origin y).
