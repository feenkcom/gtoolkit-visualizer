private-layout
calculateDiameter:  theNodes
	| dijkstra diameterVal |
	
	dijkstra := DijkstrasShortestPath new.
	diameterVal := 0.
	theNodes do: [ :firstNode |
		theNodes do: [  :secondNode |
			firstNode = secondNode
				ifFalse: [ 
					| path |
					path := dijkstra calculateShortestPathFromSourceToTargetUnweighted: theNodes source: firstNode target: secondNode.
					(path isNotNil)
						ifTrue: [ 
							| currentDistance |
							currentDistance := path size.
							diameterVal := diameterVal max: currentDistance. 
						].
				].
			].
		].
	^ diameterVal.