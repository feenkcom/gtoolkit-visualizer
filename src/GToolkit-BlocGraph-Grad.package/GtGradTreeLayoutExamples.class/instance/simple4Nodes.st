example
simple4Nodes
	<gtExample>
		
	| view theNodes pairsOfNodes edges aTreeLayout theNodePositions theNodeExtents |
	
	view := self view.
	theNodes := self nodes: (1 to: 4).
	view addChildren: theNodes. 

	pairsOfNodes := OrderedCollection new. 
	pairsOfNodes add: (1->2); add: (1->3); add:(1->4).
	edges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.
	self assert: edges size equals: 3. 

	aTreeLayout := self treeLayout.
	view layout: aTreeLayout.
	view forceLayout. 
	
   theNodeExtents := theNodes collect: [ :aNode | aNode extent ].
	theNodePositions := theNodes collect: [ :aNode | aNode position ].

	^ view

	
 