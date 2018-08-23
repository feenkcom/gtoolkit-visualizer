calculating
calculateShortestPathFromSource: theNodes source: source
"""	| settledNodes unsettledNodes distancesDict pathsDict |
	Just a sketch of how this could look like for weighted graphs	
	settledNodes := Set new.
	unsettledNodes := Set new.
	unsettledNodes add: source.
	distancesDict := IdentityDictionary new.
	pathsDict := IdentityDictionary new.
		
	unsettledNodes isEmpty
		whileFalse: [ 
			| currentNode |
			currentNode := self getLowestDistanceNode: unsettledNodes nodeDistances: distancesDict.
			(currentNode graph nodesAlongOutgoingEdgesWithWeights) associationsDo: [ :nodeAndWeigth |
				| adjacentNode weight |
				
				(settledNodes contains: adjacentNode)
					ifFalse: [
				 		self calculateMinimumDistance: adjacentNode weight: weight source: currentNode nodeDistances: distancesDict paths: pathsDict.
						unsettledNodes add: adjacentNode.					
				].
			].
			settledNodes add: currentNode.
		]. 
	"""
	
	