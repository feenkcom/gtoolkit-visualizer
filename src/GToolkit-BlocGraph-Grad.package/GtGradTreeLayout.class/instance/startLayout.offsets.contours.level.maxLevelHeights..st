calculating
startLayout: aNode offsets: anOffsetsDict contours: aContoursDict level: level maxLevelHeights: maxLevelHeightsDict
	<return: #Collection of: #Point>
	| height nodeHeight maxHeight |
	nodeHeight := aNode measuredBounds height.
	maxLevelHeightsDict at: level ifAbsentPut: [ nodeHeight ].
	maxHeight := maxLevelHeightsDict at: level.
	nodeHeight > maxHeight
		ifTrue: [ maxLevelHeightsDict at: level put: nodeHeight ].
	aNode graph connectedNodesAlongOutgoingEdges
		do: [ :child | 
			self
				startLayout: child
				offsets: anOffsetsDict
				contours: aContoursDict
				level: level + 1
				maxLevelHeights: maxLevelHeightsDict ].
	aNode graph connectedNodesAlongOutgoingEdgesCount ~= 0
		ifFalse: [ self layoutLeaf: aNode countours: aContoursDict ]
		ifTrue: [ height := self
				mergeWithChildrenContours: aNode
				offsets: anOffsetsDict
				contours: aContoursDict.
			self
				attachParent: aNode
				height: height
				offsets: anOffsetsDict
				contours: aContoursDict ]