examples - composite
containerWithCircleLayoutAndALargeNumberOfNodes
	<gtExample>
	| aContainer theNodes |
	
	aContainer := self containerWithCircleLayout.
	theNodes := self simpleNodesN: 100.
	aContainer addChildren: theNodes.
	
	aContainer forceLayout.
	
	^ aContainer.
	