calculating
startLayout: aNode offsets: anOffsetsDict
	<return: #Collection of: #Point>
	| height |
	(aNode graph connectedNodesAlongOutgoingEdges)
		do: [ :each | self startLayout: each offsets: anOffsetsDict ].
	(aNode graph connectedNodesAlongOutgoingEdgesCount) ~= 0
		ifFalse: [ ^ self ].
	height := self calculateHeightAndSetOffsets: aNode offsets: anOffsetsDict.
	self attachParent: aNode height: height offsets: anOffsetsDict