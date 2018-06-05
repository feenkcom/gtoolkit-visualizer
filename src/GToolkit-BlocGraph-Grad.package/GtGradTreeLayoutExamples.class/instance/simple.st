example
simple
	<gtExample>
		
	| view nodes edges |
	
	view := self view.
	nodes := self nodes: (1 to: 10).
	
	edges := self connectPairsOfNodes: nodes pairs: '1,2;1,3;1,4;4,5;4,6;5,7;6,8;8,9;8,10'.
	self assert: edges size equals: 9.
	
	view addChildren: nodes.
	"TODO: Apply layout"	
	^ view

	
 