calculating
setOffsetsAndContours: aNode offsets: anOffsetsDict contours: aContoursDict level: level largestNodeDimByLevel: largestNodeDimByLevel
	| height |
	aNode graph connectedNodesAlongOutgoingEdges
		do: [ :child | 
			self startLayout: child
				  offsets: anOffsetsDict
				  contours: aContoursDict
				  level: level + 1
				  largestNodeDimByLevel: largestNodeDimByLevel ].
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
