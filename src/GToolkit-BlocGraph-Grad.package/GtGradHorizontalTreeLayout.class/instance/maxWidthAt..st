api - geometry
maxWidthAt: aTreeNode
	<return: #Number>

	^ maxWidths
		at: aTreeNode depth
		ifAbsentPut: [ aTreeNode maxDepthWidth ]