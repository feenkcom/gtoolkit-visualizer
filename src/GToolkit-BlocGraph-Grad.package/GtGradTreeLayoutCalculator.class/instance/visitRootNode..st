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

	origin := self origin + ((bounds x + self treesDistance) @ self origin y)