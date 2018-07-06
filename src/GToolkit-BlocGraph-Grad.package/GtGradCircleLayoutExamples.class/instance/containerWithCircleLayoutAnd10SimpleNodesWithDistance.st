examples - layout
containerWithCircleLayoutAnd10SimpleNodesWithDistance
	<gtExample>
	| aContainer theNodes distance|

	distance := 100.
	aContainer := self containerWithCircleLayout: distance. 
	theNodes := self simpleNodes10.
	aContainer addChildren: theNodes.
	
	aContainer forceLayout.
	
	self assert: aContainer position equals: 0@0. 




	^ aContainer