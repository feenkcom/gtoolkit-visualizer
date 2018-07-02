examples - layout
bigNodesN: num
	<gtExample>

	^ num timesCollect: [
		| aNode |
		aNode := self bigRectangle.
		aNode graph beNode.
		aNode ]