scripting
connectFrom: aFromBlock toAll: aToBlock
	^ self
		connect:
			(self topStep root graph nodeChildren
				collect: [ :each | each graph model ])
		from: aFromBlock
		toAll: aToBlock