calculating
startLayout: aNode offsets: anOffsetsDict
	<return: #Collection of: #Point>

	(self childrenNodes: aNode) do: [ :each |
			| height |
			self startLayout: each offsets: anOffsetsDict.
			((self childrenCount: each) = 0)
				ifFalse: [
						height := self calculateHeightAndSetOffsets: each offsets: anOffsetsDict.
						self attachParent: each height: height offsets: anOffsetsDict.
					].
		 ].

