scripting
connectFrom: aFromBlock to: aToBlock
	^ self
		connect:
			(self topStep root graph nodeChildren
				collect: [ :each | each graph model ])
		from: aFromBlock
		to: aToBlock