api - adding
add: aTreeNode
	
	aTreeNode parent: self.
	aTreeNode depth: self depth + 1.

	self nodes add: aTreeNode