example
simpleTreeReversed
	<gtExample>
		
	| view theNodes aTreeLayout theNodePositions theNodeExtents |
	
	view := self view. 
	aTreeLayout := self treeLayout.
	aTreeLayout reverse: true.
	theNodes := self constructSimpleTree key.
	view addChildren: theNodes.
	
	view layout: aTreeLayout.
	view forceLayout. 
	
   theNodeExtents := theNodes collect: [ :aNode | aNode extent ].
	theNodePositions := theNodes collect: [ :aNode | aNode position ].
	
	self assert: theNodeExtents asArray equals: (15 timesCollect: [ self nodeExtent ]).

	^ view