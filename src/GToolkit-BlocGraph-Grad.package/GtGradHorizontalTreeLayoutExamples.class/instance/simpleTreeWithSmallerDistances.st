example
simpleTreeWithSmallerDistances
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view. 
	aTreeLayout := self treeLayout: 10 nodeDistance: 5.
	theNodes := self constructSimpleTree key.
	view addChildren: theNodes. 
	
	view layout: aTreeLayout.
	view forceLayout. 
	  

	^ view