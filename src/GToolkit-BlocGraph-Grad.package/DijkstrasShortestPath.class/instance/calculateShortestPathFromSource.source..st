calculating
calculateShortestPathFromSource: theNodes source: source
	| settledNodes unsettledNodes path |
	
	settledNodes := IdentityDictionary new.
	unsettledNodes := Set new.
	
	unsettledNodes add: source.
	
	unsettledNodes isEmpty
		whileFalse: [ 
			| currentNode |
			currentNode := self getLowestDistanceNode: unsettledNodes.
			(currentNode graph nodesAlongOutgoingEdges) do: [ :aNode |
				
				
			].
		]. 
	
	
	