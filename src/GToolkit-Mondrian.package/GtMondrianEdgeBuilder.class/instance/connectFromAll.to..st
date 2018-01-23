scripting
connectFromAll: aFromBlock to: aToBlock
	^ self
		connect: 
			(self topStep root graph nodeChildren
				collect: [ :each | each graph model ])
		fromAll: aFromBlock
		to: aToBlock