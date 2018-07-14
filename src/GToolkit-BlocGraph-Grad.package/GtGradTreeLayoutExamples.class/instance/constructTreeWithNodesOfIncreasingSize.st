example
constructTreeWithNodesOfIncreasingSize
	<gtExample>
		
	| theNodes  pairsOfNodes theEdges |
	
	theNodes := self nodes: (1 to: 15).
	
	theNodes doWithIndex: [ :aNodeElement :index |
		aNodeElement size: 10 asPoint * index.
	].
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add:(2->4); add: (2->5); add: (3->6); add: (3->7);
	add: (4->8); add: (4->9); add: (5->10); add: (5->11); add: (6->12); add: (6->13); add: (6->14); 	add: (6->15).
	
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.
	
	self assert: ((theNodes at: 1) graph) nodesAlongOutgoingEdgesCount equals: 2.
	self assert: ((theNodes at: 1) graph) nodesAlongIncomingEdgesCount equals: 0.
	self assert: ((theNodes at: 2) graph) nodesAlongOutgoingEdgesCount equals: 2.
	self assert: ((theNodes at: 2) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 6) graph) nodesAlongOutgoingEdgesCount equals: 4. 
	self assert: ((theNodes at: 6) graph) nodesAlongIncomingEdgesCount equals: 1. 
	self assert: ((theNodes at: 15) graph) nodesAlongOutgoingEdgesCount equals: 0.
	self assert: ((theNodes at: 15) graph) nodesAlongIncomingEdgesCount equals: 1.

	self assert: theEdges size equals: 14.

	^ theNodes -> theEdges

	
 