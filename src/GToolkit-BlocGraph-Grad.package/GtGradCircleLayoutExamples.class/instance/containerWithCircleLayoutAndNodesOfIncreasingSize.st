examples - layout
containerWithCircleLayoutAndNodesOfIncreasingSize
	<gtExample>
	| aContainer theNodes |

	aContainer := self containerWithCircleLayout.
	theNodes := self createNNodesOfIncreasingSize: 10.
	aContainer addChildren: theNodes.
	
	aContainer forceLayout.
	
	self assert: aContainer position equals: 0@0.
		
	^ aContainer