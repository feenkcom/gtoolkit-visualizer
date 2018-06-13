calculating
startLayout: aNode offsets: anOffsetsDict
	<return: #Collection of: #Point>
	| height |
	(self nodesConnectedToNode: aNode)
		do: [ :each | self startLayout: each offsets: anOffsetsDict ].
	(self nodesConnectedToNodeCount: aNode) ~= 0
		ifFalse: [ ^ self ].
	height := self calculateHeightAndSetOffsets: aNode offsets: anOffsetsDict.
	self attachParent: aNode height: height offsets: anOffsetsDict