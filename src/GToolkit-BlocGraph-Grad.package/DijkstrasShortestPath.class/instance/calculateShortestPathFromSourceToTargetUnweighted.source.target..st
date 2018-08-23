calculating
calculateShortestPathFromSourceToTargetUnweighted: theNodes source: source target: target
	| settledNodes unsettledNodes distancesDict pathsDict targetNotReached |
	
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
	targetNotReached := true.
	[unsettledNodes isNotEmpty and: [targetNotReached]]
		whileTrue: [ 
			| currentNode |
			currentNode := self getLowestDistanceNode: unsettledNodes nodeDistances: distancesDict.
			unsettledNodes remove: currentNode.
			(currentNode graph nodesAlongOutgoingEdges) do: [ :adjacentNode |
				(settledNodes includes: adjacentNode)
					ifFalse: [
				 		self calculateMinimumDistance: adjacentNode weight: 1 source: currentNode nodeDistances: distancesDict paths: pathsDict.
						adjacentNode = target 
							ifTrue: [ targetNotReached := false ]
							ifFalse: [ unsettledNodes add: adjacentNode ].	
				].
			].
			settledNodes add: currentNode.
		]. 
	
	(pathsDict includesKey: target)
		ifTrue:  [^ pathsDict at: target].
	^ nil
	
