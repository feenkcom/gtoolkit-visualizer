Class {
	#name : #DijkstrasShortestPath,
	#superclass : #Object,
	#category : #'GToolkit-BlocGraph-Grad-Algorithms'
}

{ #category : #calculating }
DijkstrasShortestPath >> calculateMinimumDistance: aNode weight: weight source: sourceNode nodeDistances: aNodeDistancesDict paths: aPathsDict [
	| sourceDistance nodeDistance shortestPath |
	sourceDistance := aNodeDistancesDict at: sourceNode.
	nodeDistance := aNodeDistancesDict at: aNode.
	sourceDistance + weight < nodeDistance
		ifFalse: [ ^ self ].
	aNodeDistancesDict at: aNode put: sourceDistance + weight.
	shortestPath := OrderedCollection new.
	shortestPath addAll: (aPathsDict at: sourceNode).
	shortestPath add: sourceNode.
	aPathsDict at: aNode put: shortestPath
]

{ #category : #calculating }
DijkstrasShortestPath >> calculateShortestPathFromSource: theNodes source: source [
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
	
	
]

{ #category : #calculating }
DijkstrasShortestPath >> calculateShortestPathFromSourceToTargetUnweighted: theNodes source: source target: target [
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
			(currentNode nodesAlongOutgoingEdges) do: [ :adjacentNode |
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
	

]

{ #category : #calculating }
DijkstrasShortestPath >> calculateShortestPathFromSourceUnweighted: theNodes source: source [
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
			unsettledNodes remove: currentNode.
			(currentNode nodesAlongOutgoingEdges) do: [ :adjacentNode |
				(settledNodes includes: adjacentNode)
					ifFalse: [
				 		self calculateMinimumDistance: adjacentNode weight: 1 source: currentNode nodeDistances: distancesDict paths: pathsDict.
						unsettledNodes add: adjacentNode.					
				].
			].
			settledNodes add: currentNode.
		]. 
	
	^ pathsDict
	
	
	
]

{ #category : #calculating }
DijkstrasShortestPath >> getLowestDistanceNode: unsettledNodes nodeDistances: aNodeDistancesDict [
	| lowestDistance lowestDistanceNode |
	
	lowestDistanceNode := nil.
	lowestDistance := SmallInteger maxVal.
	unsettledNodes do: [ :aNode |
		| aNodeDistance |
		aNodeDistance := aNodeDistancesDict at: aNode.
		aNodeDistance < lowestDistance
			ifTrue: [ 
				lowestDistance := aNodeDistance.
				lowestDistanceNode := aNode.	
			].
	].
	
	^ lowestDistanceNode
	
]
