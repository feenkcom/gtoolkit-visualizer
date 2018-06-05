building - graph
connectPairsOfNodes: nodes pairs: pairsOfNodes
	| splitPairs |
	splitPairs := pairsOfNodes splitOn: ';'.
	^ splitPairs collect: [ :pair |
		| fromNode toNode pairElements| 
		pairElements := pair splitOn: ','.
		fromNode := nodes at:  ((pairElements at: 1) trim) asNumber.
		toNode := nodes at: ((pairElements at: 2) trim) asNumber.
		self connectNodesFrom: fromNode to: toNode.
	]

