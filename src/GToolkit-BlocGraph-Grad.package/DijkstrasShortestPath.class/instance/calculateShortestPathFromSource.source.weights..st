calculating
calculateShortestPathFromSource: theNodes source: source weights: nodeWeights
	| settledNodes unsettledNodes distancesDict pathsDict |
	
	settledNodes := Set new.
	unsettledNodes := Set new.
	unsettledNodes add: source.
	"TODO refactor this"
	distancesDict := IdentityDictionary new.
	pathsDict := IdentityDictionary new.
		
	unsettledNodes isEmpty
		whileFalse: [ 
			| currentNode |
			currentNode := self getLowestDistanceNode: unsettledNodes nodeDistances: distancesDict.
			(currentNode graph nodesAlongOutgoingEdges) do: [ :adjacentNode |
				(settledNodes contains: adjacentNode)
					ifFalse: [
						| weight |
 						 weight := nodeWeights at: adjacentNode.
				 		self calculateMinimumDistance: adjacentNode weight: weight source: currentNode nodeDistances: distancesDict paths: pathsDict.
						unsettledNodes add: adjacentNode.					
				].
			].
			settledNodes add: currentNode.
		]. 
	
	
	