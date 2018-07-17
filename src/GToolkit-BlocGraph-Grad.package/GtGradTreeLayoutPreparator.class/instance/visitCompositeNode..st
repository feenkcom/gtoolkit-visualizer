visiting
visitCompositeNode: aTreeNode
	| theChildrenBreadth |

	theChildrenBreadth := self mergeWithChildrenContours: aTreeNode.

	self
		attachParent: aTreeNode
		breadth: theChildrenBreadth