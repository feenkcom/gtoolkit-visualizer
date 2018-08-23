private-layout
calculateDiameter:  theNodes
	| dijkstra diameterVal |
	
	dijkstra := DijkstrasShortestPath new.
	diameterVal := 0.
	theNodes do: [ :firstNode |
		theNodes do: [  :secondNode |
			firstNode = secondNode
				ifFalse: [ 
					| paths |
					paths := dijkstra calculateShortestPathFromSourceUnweighted: theNodes source: firstNode.
					(paths includesKey: secondNode)
						ifTrue: [ 
							| currentDistance |
							currentDistance := (paths at: secondNode) size.
							diameterVal := diameterVal max: currentDistance. 
						].
				].
			].
		].
	^ diameterVal.