example
simple
	<gtExample>
		
	| view theNodes pairsOfNodes edges aTreeLayout theNodePositions theNodeExtents |
	
	view := self view.
	theNodes := self nodes: (1 to: 9).
	view addChildren: theNodes. 

	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add:(1->4); add: (2->5); add: (3->6); add: (3->7); add: (7->8); add: (4->9).
	edges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.
	self assert: ((theNodes at: 1) graph) connectedNodesAlongOutgoingEdgesCount equals: 3.
	self assert: ((theNodes at: 1) graph) connectedNodesAlongIncomingEdgesCount equals: 0.
	self assert: ((theNodes at: 2) graph) connectedNodesAlongOutgoingEdgesCount equals: 1.
	self assert: ((theNodes at: 2) graph) connectedNodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 2) graph) connectedNodesCount equals: 2. 

	self assert: edges size equals: 8.

	aTreeLayout := self treeLayout.
	view layout: aTreeLayout.
	view forceLayout. 
	
   theNodeExtents := theNodes collect: [ :aNode | aNode extent ].
	theNodePositions := theNodes collect: [ :aNode | aNode position ].

	^ view

	
 