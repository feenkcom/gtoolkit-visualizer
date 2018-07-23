example
simpleTreeWithNodesOfIncreasingSizeCenterAlignment
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view. 
	aTreeLayout := self treeLayout. 
	aTreeLayout nodesAlignment: GtGradTreeNodesCenterAlignment new.
	theNodes := self constructTreeWithNodesOfIncreasingSize key.
	view addChildren: theNodes. 
	
	view layout: aTreeLayout.
	view forceLayout. 
	  

	^ view