calculating
startLayout: aNode offsets: anOffsetsDict contours: aContoursDict
	<return: #Collection of: #Point>
	| height |
	(aNode graph connectedNodesAlongOutgoingEdges)
		do: [ :each | self startLayout: each offsets: anOffsetsDict contours: aContoursDict].
	(aNode graph connectedNodesAlongOutgoingEdgesCount) ~= 0
		ifFalse: [
			self layoutLeaf: aNode countours: aContoursDict  
		]
		ifTrue: [ 
			height := self mergeWithChildrenContours: aNode offsets: anOffsetsDict contours: aContoursDict.
			self attachParent: aNode height: height offsets: anOffsetsDict contours: aContoursDict
	].