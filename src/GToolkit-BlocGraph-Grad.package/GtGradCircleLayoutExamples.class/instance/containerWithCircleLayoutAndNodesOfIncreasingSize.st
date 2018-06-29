examples - layout
containerWithCircleLayoutAndNodesOfIncreasingSize
	<gtExample>
	| aContainer theNodes theNodeExtents theNodePositions |

	aContainer := self containerWithCircleLayout.
	theNodes := self create10NodesOfIncreasingSize.
	aContainer addChildren: theNodes.
	
	aContainer forceLayout.
	
	self assert: aContainer position equals: 0@0.
	"self assert: aContainer extent equals: (977@896)."
		
	^ aContainer