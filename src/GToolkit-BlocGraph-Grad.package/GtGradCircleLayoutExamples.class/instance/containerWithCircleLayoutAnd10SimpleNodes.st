examples - layout
containerWithCircleLayoutAnd10SimpleNodes
	<gtExample>
	| aContainer theNodes theNodeExtents theNodePositions |

	aContainer := self containerWithCircleLayout.
	theNodes := self simpleNodes10.
	aContainer addChildren: theNodes.
	
	aContainer forceLayout.
	
	self assert: aContainer position equals: 0@0.
	self assert: aContainer extent equals: (200@180).
	
	theNodeExtents := theNodes collect: [ :aNode | aNode extent ].
	theNodePositions := theNodes collect: [ :aNode | aNode position ]. 
	
	self assert: theNodeExtents asArray equals: (10 timesCollect: [ self nodeExtent ]).
	self
		assert: theNodePositions asArray
		equals: { (180.0@85.0). (162.0@137.0). (117.0@170.0). (63.0@170.0). (18.0@137.0). (0.0@85.0). (18.0@33.0). (63.0@0.0). (117.0@0.0). (162.0@33.0)}.

	^ aContainer