calculating
findRoot: nodes
	
	^ nodes detect: [  :node |
		node graph connectedNodesAlongIncomingEdgesCount = 0
		ifTrue:[
			^ node.	
		]
	].
