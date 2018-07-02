examples - layout
simpleNodesN: num
	<gtExample>

	^ num timesCollect: [
		| aNode |
		aNode := self rectangle.
		aNode graph beNode.
		aNode ]