visiting
visitCompositeNode: aTreeNode
	| aHeight |

	aHeight := self mergeWithChildrenContours: aTreeNode.

	self
		attachParent: aTreeNode
		height: aHeight