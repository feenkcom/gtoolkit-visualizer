accessing
maxWidthAt: aTreeNode
	<return: #Number>
	
	maxWidths isNil
		ifTrue: [ maxWidths := PluggableDictionary new ].

	^ maxWidths
		at: aTreeNode depth
		ifAbsentPut: [ aTreeNode maxDepthWidth ]