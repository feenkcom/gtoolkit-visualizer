example
simpleTreeWithBiggerDistances
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view. 
	aTreeLayout := self treeLayout: 50 nodeDistance: 100.
	theNodes := self constructSimpleTree key.
	view addChildren: theNodes. 
	
	view layout: aTreeLayout.
	view forceLayout. 
	  

	^ view