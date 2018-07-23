example
simpleTreeWith10NodesOfIncreasingSizeTopAlignment
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view. 
	aTreeLayout := self treeLayout. 
	aTreeLayout nodesAlignment: GtGradTreeNodesTopAlignment new.
	theNodes := self constructTreeWith10NodesOfIncreasingSize key.
	view addChildren: theNodes. 
	
	view layout: aTreeLayout.
	view forceLayout. 
	  

	^ view