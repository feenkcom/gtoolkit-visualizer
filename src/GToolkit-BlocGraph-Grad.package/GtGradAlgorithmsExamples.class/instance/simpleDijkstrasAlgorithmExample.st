example
simpleDijkstrasAlgorithmExample
	<gtExample>
	| theNodes  pairsOfNodes algorithm|
	
	theNodes := self nodes: (1 to: 6).
	theNodes doWithIndex: [ :node :index |
			node labeled: (index asString).
		].
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add: (2->4);
					 add: (3->5); add: (4->5); add: (2->6);
					 add: (4->6); add: (6->5).
	self connectPairsOfNodes: theNodes pairs: pairsOfNodes.
	algorithm := DijkstrasShortestPath new.
	algorithm calculateShortestPathFromSourceUnweighted: theNodes source: (theNodes at: 1).
