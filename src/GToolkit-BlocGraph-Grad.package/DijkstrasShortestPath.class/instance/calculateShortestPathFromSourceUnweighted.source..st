calculating
calculateShortestPathFromSourceUnweighted: theNodes source: source
	| settledNodes unsettledNodes distancesDict pathsDict |
	
	 
	settledNodes := Set new.
	unsettledNodes := Set new.
	unsettledNodes add: source.
	"TODO refactor this"
	distancesDict := IdentityDictionary new.
	pathsDict := IdentityDictionary new.
	
	theNodes do: [ :aNode |
		distancesDict at: aNode put: (SmallInteger maxVal).
		pathsDict at: aNode put: (OrderedCollection new).
	].
	distancesDict at: source put: 0.
	
		
	[unsettledNodes isNotEmpty]
		whileTrue: [ 
			| currentNode |
			currentNode := self getLowestDistanceNode: unsettledNodes nodeDistances: distancesDict.
			(currentNode graph nodesAlongOutgoingEdges) do: [ :adjacentNode |
				(settledNodes contains: adjacentNode)
					ifFalse: [
				 		self calculateMinimumDistance: adjacentNode weight: 1 source: currentNode nodeDistances: distancesDict paths: pathsDict.
						unsettledNodes add: adjacentNode.					
				].
			].
			settledNodes add: currentNode.
		]. 
	
	
	