api - geometry
nodeBottomAlignmentCorrection: aTreeNode aRootNode: aRootNode

	^ 0@((aRootNode maxHeightAt: aTreeNode) - aTreeNode element height)