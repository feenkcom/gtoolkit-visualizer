example
simpleTreeWithNodesOfIncreasingSize
	<gtExample>
	| view theNodes aTreeLayout |

	view := self view. 
	aTreeLayout := self treeLayout.
	theNodes := self constructTreeWithNodesOfIncreasingSize key.
	view addChildren: theNodes. 

	view layout: aTreeLayout.
	view forceLayout. 

	^ view