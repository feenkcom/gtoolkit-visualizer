examples - layout
containerWithCircleLayoutAnd10SimpleNodes
	<gtExample>
	| aContainer theNodes theNodeExtents theNodePositions |

	aContainer := self containerWithCircleLayout.
	theNodes := self simpleNodes10.
	aContainer addChildren: theNodes.
	
	aContainer forceLayout.
	
	self assert: aContainer position equals: 0@0.
	self assert: aContainer extent equals: (420@390).
	
	theNodeExtents := theNodes collect: [ :aNode | aNode extent ].
	theNodePositions := theNodes collect: [ :aNode | aNode position ].
	
	self assert: theNodeExtents asArray equals: (10 timesCollect: [ self nodeExtent ]).
	self
		assert: theNodePositions asArray
		equals: { (400.0@190.0). (361.0@307.0). (261.0@380.0). (139.0@380.0). (39.0@307.0). (0.0@190.0). (39.0@73.0). (139.0@0.0). (261.0@0.0). (361.0@73.0)}.

	^ aContainer