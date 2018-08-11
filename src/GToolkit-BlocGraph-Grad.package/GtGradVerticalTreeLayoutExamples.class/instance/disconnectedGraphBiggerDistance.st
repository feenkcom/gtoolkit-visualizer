example
disconnectedGraphBiggerDistance
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view.
	aTreeLayout := self treeLayout.
	aTreeLayout treesDistance: 150.
	theNodes := self constructDisconnectedGraph  key.
	view addChildren: theNodes.
	view layout: aTreeLayout.
	view forceLayout. 

	^ view