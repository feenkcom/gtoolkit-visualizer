visiting
visitRootNode: aTreeNode
	| bounds |

	GtGradProcessingTreeSignal new
		root: aTreeNode;
		emit.

	bounds := self
		layout: aTreeNode
		start: self origin
		bounds: 0@0.


	self reverse
		ifTrue: [ 
			self reverse: aTreeNode
			     rootPosition: (aTreeNode element constraints gradTree computedPosition)
			     bounds: bounds
		].

	origin := self origin + ((bounds x + self treesDistance) @ 0)