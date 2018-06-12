building - graph
connectPairsOfNodes: nodes pairs: pairsOfNodes
	^ pairsOfNodes collect: [ :aPair |
		| fromNode toNode |
		fromNode := nodes at: aPair key.
		toNode := nodes at: aPair value.
		self connectNodesFrom: fromNode to: toNode.
	]

