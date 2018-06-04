examples - layout
simpleTreeNodes10
	<gtExample>

	| nodes root node5|
	
	nodes :=  10 timesCollect: [
		| anEditor |
		anEditor := self rectangle.
		anEditor graph beNode.
		anEditor ].
	
	root := nodes first.
	root addChild: (nodes at: 2).
	root addChild: (nodes at: 3).
	root addChild: (nodes at: 4).
	root addChild: (nodes at: 5).
	node5 := (nodes at: 5).
	node5 addChild: (nodes at: 6).
	node5 addChild: (nodes at: 7).
	node5 addChild: (nodes at: 8).
	node5 addChild: (nodes at: 9).
	node5 addChild: (nodes at: 10).
	
	^ Array with: root.
	