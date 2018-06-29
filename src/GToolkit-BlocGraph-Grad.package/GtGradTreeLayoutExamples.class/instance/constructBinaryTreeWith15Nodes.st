example
constructBinaryTreeWith15Nodes
	<gtExample>
		
	| theNodes  pairsOfNodes theEdges |
	
	theNodes := self nodes: (1 to: 15). 
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add:(2->4); add: (2->5); add: (3->6); add: (3->7);
	add: (4->8); add: (4->9); add: (5->10); add: (5->11); add: (6->12); add: (6->13);
	add: (7->14); add: (7->15).
	
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.
	
	self assert: ((theNodes at: 1) graph) connectedNodesAlongOutgoingEdgesCount equals: 2.
	self assert: ((theNodes at: 1) graph) connectedNodesAlongIncomingEdgesCount equals: 0.
	self assert: ((theNodes at: 2) graph) connectedNodesAlongOutgoingEdgesCount equals: 2.
	self assert: ((theNodes at: 2) graph) connectedNodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 2) graph) connectedNodesCount equals: 3.
	self assert: ((theNodes at: 14) graph) connectedNodesAlongOutgoingEdgesCount equals: 0. 
	self assert: ((theNodes at: 14) graph) connectedNodesAlongIncomingEdgesCount equals: 1. 
	self assert: ((theNodes at: 15) graph) connectedNodesAlongOutgoingEdgesCount equals: 0.
	self assert: ((theNodes at: 15) graph) connectedNodesAlongIncomingEdgesCount equals: 1.

	self assert: theEdges size equals: 14.

	^ theNodes -> theEdges

	
 