example
simpleDijkstrasAlgorithmExample
	<gtExample>
	| theNodes  pairsOfNodes algorithm paths |
	
	theNodes := self nodes: (1 to: 7).
	theNodes doWithIndex: [ :node :index |
			node labeled: (index asString).
		].
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add: (2->4);
					 add: (3->5); add: (4->5); add: (3->6);
					 add: (4->6); add: (6->5); add:(6->7).
	self connectPairsOfNodes: theNodes pairs: pairsOfNodes.
	algorithm := DijkstrasShortestPath new.
	paths := algorithm calculateShortestPathFromSourceUnweighted: theNodes source: (theNodes at: 1).
	
	self assert: ((paths at: (theNodes at: 2)) size) equals: 1.
	self assert: ((paths at: (theNodes at: 3)) size) equals: 1.
	self assert: ((paths at: (theNodes at: 4)) size) equals: 2.
	self assert: ((paths at: (theNodes at: 5)) size) equals: 2.
	self assert: ((paths at: (theNodes at: 6)) size) equals: 2.
	self assert: ((paths at: (theNodes at: 7)) size) equals: 3.

