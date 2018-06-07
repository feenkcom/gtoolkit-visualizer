calculating
"protocol: #calculating"

startLayout: aNode
	<return: #Collection of: #Point>
	
	| offsets |
	offsets := IdentityDictionary new.

	(aNode children) do: [ :each |
			| height |
			self startLayout: each.
			(each childrenCount = 0)
				ifFalse: [
						height := self calculateHeightAndSetOffsets: each offsets: offsets.
						self attachParent: each height: height offsets: offsets.
					].
		 ].