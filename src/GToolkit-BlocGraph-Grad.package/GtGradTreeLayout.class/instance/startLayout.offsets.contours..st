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
			height := self calculateHeightAndSetOffsets: aNode offsets: anOffsetsDict.
			self attachParent: aNode height: height offsets: anOffsetsDict
	].