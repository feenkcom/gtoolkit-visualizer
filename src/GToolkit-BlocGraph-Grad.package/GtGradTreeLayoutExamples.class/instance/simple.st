example
simple
	<gtExample>
		
	| view theNodes edges aTreeLayout theNodePositions theNodeExtents |
	
	view := self view.
	theNodes := self nodes: (1 to: 10).
	view addChildren: theNodes.

	edges := self connectPairsOfNodes: theNodes pairs: '1,2;1,3;1,4;4,5;4,6;5,7;6,8;8,9;8,10'.
	self assert: edges size equals: 9.

	aTreeLayout := self treeLayout.
	view layout: aTreeLayout.
	view forceLayout. 
	
   theNodeExtents := theNodes collect: [ :aNode | aNode extent ].
	theNodePositions := theNodes collect: [ :aNode | aNode position ]. 

	^ view

	
 