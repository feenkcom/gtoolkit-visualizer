example
constructTreeWith10NodesOfIncreasingSize
	<gtExample>
		
	| theNodes  pairsOfNodes theEdges |
	
	theNodes := self nodes: (1 to: 10).
	
	theNodes doWithIndex: [ :aNodeElement :index |
		aNodeElement size: 10 asPoint * index.
	].
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add:(2->4); add: (2->5); add: (3->6); add: (3->7);
	add: (4->8); add: (4->9); add: (5->10).
	
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.
	

	^ theNodes -> theEdges

	
 