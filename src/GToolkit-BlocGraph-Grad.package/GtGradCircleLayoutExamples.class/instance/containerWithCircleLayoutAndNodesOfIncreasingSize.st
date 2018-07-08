examples - layout
containerWithCircleLayoutAndNodesOfIncreasingSize
	<gtExample>
	| aContainer theNodes |

	aContainer := self containerWithCircleLayout.
	theNodes := self createNNodesOfIncreasingSize: 10.
	aContainer addChildren: theNodes.
	
	aContainer forceLayout.
	
	self assert: aContainer position equals: 0@0. 
	"self assert: aContainer extent equals: (977@896)."
		
	^ aContainer