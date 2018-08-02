accessing
maxHeightAt: aTreeNode
	<return: #Number>

	maxHeights isNil
		ifTrue: [ maxHeights := PluggableDictionary new ].

	^ maxHeights
		at: aTreeNode depth
		ifAbsentPut: [ aTreeNode maxDepthHeight ]