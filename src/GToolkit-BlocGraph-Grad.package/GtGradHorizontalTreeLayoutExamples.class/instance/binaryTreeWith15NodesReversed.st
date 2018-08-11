example
binaryTreeWith15NodesReversed
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view.
	aTreeLayout := self treeLayout.
	aTreeLayout reverse: true.
	theNodes := self constructBinaryTreeWith15Nodes key.
	view addChildren: theNodes. 
	view layout: aTreeLayout.
	view forceLayout. 

	^ view