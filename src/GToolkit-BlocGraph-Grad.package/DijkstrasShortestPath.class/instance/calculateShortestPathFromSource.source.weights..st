calculating
calculateShortestPathFromSource: theNodes source: source weights: nodeWeights
	| settledNodes unsettledNodes |
	
	settledNodes := Set new.
	unsettledNodes := Set new.
	
	unsettledNodes add: source.
	
	unsettledNodes isEmpty
		whileFalse: [ 
			| currentNode |
			currentNode := self getLowestDistanceNode: unsettledNodes.
			(currentNode graph nodesAlongOutgoingEdges) do: [ :adjacentNode |
				(settledNodes contains: adjacentNode)
					ifFalse: [
						| weight |
 						 weight := nodeWeights at: adjacentNode.
				 		self calculateMinimumDistance: adjacentNode weight: weight currentNode: currentNode.
						unsettledNodes add: adjacentNode.
						
				].
			].
			settledNodes add: currentNode.
		]. 
	
	
	