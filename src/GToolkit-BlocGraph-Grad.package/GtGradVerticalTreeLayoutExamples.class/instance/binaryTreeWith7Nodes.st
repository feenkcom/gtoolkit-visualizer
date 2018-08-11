example
binaryTreeWith7Nodes
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view.
	theNodes := self constructBinaryTreeWith7Nodes key. 
	view addChildren: theNodes. 
	aTreeLayout := self treeLayout.
	view layout: aTreeLayout. 
	view forceLayout. 
		
	^ view

	
 