api - geometry
maxHeightAt: aTreeNode
	<return: #Number>

	^ maxHeights
		at: aTreeNode depth
		ifAbsentPut: [ aTreeNode maxDepthHeight ]