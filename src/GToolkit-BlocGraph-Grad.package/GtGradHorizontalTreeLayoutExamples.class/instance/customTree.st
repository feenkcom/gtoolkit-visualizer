example
customTree
	<gtExample>
		
	| view theNodes pairsOfNodes edges aTreeLayout theNodePositions theNodeExtents |
	
	view := self view. 
	theNodes := self nodes: (1 to: 15). 
	view addChildren: theNodes. 

	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add:(2->4); add: (2->5); add: (3->6); add: (3->7);
	add: (4->8); add: (4->9); add: (5->10); add: (5->11); add: (6->12); add: (6->13); add: (6->14); add: 	(6->15). 
	
	edges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.


	aTreeLayout := self treeLayout.
	view layout: aTreeLayout.
	view forceLayout. 
	
   theNodeExtents := theNodes collect: [ :aNode | aNode extent ].
	theNodePositions := theNodes collect: [ :aNode | aNode position ].

	^ view

	
 