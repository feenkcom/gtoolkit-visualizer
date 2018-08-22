calculating
calculateMinimumDistance: aNode weight: weight source: sourceNode nodeDistances: aNodeDistancesDict paths: aPathsDict
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