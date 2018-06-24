example
binaryTreeWith7Nodes
	<gtExample>
		
	| view theNodes pairsOfNodes edges aTreeLayout theNodePositions theNodeExtents |
	
	view := self view. 
	theNodes := self nodes: (1 to: 7).
	view addChildren: theNodes.

	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add:(2->4); add: (2->5); add: (3->6); add: (3->7).
	
	edges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.


	aTreeLayout := self treeLayout.
	view layout: aTreeLayout.
	view forceLayout. 
	
   theNodeExtents := theNodes collect: [ :aNode | aNode extent ].
	theNodePositions := theNodes collect: [ :aNode | aNode position ].

	^ view

	
 