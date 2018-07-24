example
binaryTreeWith7NodesRevered
	<gtExample>
		
	| view theNodes  aTreeLayout theNodePositions theNodeExtents |
	
	view := self view.
	theNodes := self constructBinaryTreeWith7Nodes key.
	
	view addChildren: theNodes.

	aTreeLayout := self treeLayout.
	aTreeLayout reverse: true.
	view layout: aTreeLayout.
	view forceLayout. 
	
   theNodeExtents := theNodes collect: [ :aNode | aNode extent ].
	theNodePositions := theNodes collect: [ :aNode | aNode position ].

	self assert: theNodeExtents asArray equals: (7 timesCollect: [ self nodeExtent ]).
	
	^ view

	
 