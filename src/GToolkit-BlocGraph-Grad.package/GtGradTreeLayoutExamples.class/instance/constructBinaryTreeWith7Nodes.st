example
constructBinaryTreeWith7Nodes
	<gtExample>
		
	| theNodes  pairsOfNodes theEdges |
	
	theNodes := self nodes: (1 to: 7).
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add:(2->4); add: (2->5); add: (3->6); add: (3->7).
	
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.
	
	self assert: ((theNodes at: 1) graph) nodesAlongOutgoingEdgesCount equals: 2.
	self assert: ((theNodes at: 1) graph) nodesAlongIncomingEdgesCount equals: 0.
	self assert: ((theNodes at: 2) graph) nodesAlongOutgoingEdgesCount equals: 2.
	self assert: ((theNodes at: 2) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 2) graph) connectedNodesCount equals: 3.
	self assert: ((theNodes at: 6) graph) nodesAlongOutgoingEdgesCount equals: 0. 
	self assert: ((theNodes at: 6) graph) nodesAlongIncomingEdgesCount equals: 1. 
	self assert: ((theNodes at: 7) graph) nodesAlongOutgoingEdgesCount equals: 0.
	self assert: ((theNodes at: 7) graph) nodesAlongIncomingEdgesCount equals: 1.

	self assert: theEdges size equals: 6.

	^ theNodes -> theEdges

	
 