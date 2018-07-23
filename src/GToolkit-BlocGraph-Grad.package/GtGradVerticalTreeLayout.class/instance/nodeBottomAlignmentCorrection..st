api - geometry
nodeBottomAlignmentCorrection: aTreeNode

	^ 0@((self maxHeightAt: aTreeNode) - aTreeNode element height)