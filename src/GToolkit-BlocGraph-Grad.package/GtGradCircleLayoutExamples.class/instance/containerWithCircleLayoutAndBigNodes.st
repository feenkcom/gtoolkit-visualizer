examples - layout
containerWithCircleLayoutAndBigNodes
	<gtExample>
	| aContainer theNodes  |

	aContainer := self containerWithCircleLayout. 
	theNodes := self bigNodesN: 10. 
	aContainer addChildren: theNodes.
	
	aContainer forceLayout.
	
	self assert: aContainer position equals: 0@0.

		
	^ aContainer