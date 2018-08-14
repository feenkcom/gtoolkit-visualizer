examples - layout
containerWithCircleLayoutAnd10SimpleNodes
	<gtExample>
	| aContainer theNodes theNodeExtents theNodePositions |

	aContainer := self containerWithCircleLayout.
	theNodes := self simpleNodes10.
	aContainer addChildren: theNodes.
	
	aContainer forceLayout.
	
	self assert: aContainer position equals: 0@0.
	self assert: aContainer extent equals: (296@254).
	
	theNodeExtents := theNodes collect: [ :aNode | aNode extent ].
	theNodePositions := theNodes collect: [ :aNode | aNode position ]. 
	
	self assert: theNodeExtents asArray equals: (10 timesCollect: [ self nodeExtent ]).
	self
		assert: theNodePositions asArray
		equals: {(246.0@117.0). (223.0@189.0). (161.0@234.0). (85.0@234.0). (23.0@189.0). (0.0@117.0). (23.0@45.0). (85.0@0.0). (161.0@0.0). (223.0@45.0)}.

	^ aContainer