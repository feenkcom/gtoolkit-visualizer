examples - layout
simpleNodes10
	<gtExample>

	^ 10 timesCollect: [
		| anEditor |
		anEditor := self rectangle.
		anEditor graph beNode.
		anEditor ]