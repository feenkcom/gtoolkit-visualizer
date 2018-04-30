tutorial - shapes
edgesWithTextAndThickerLinesHorizontalTree
	<gtExample>
	| view |
	view := self nodesWithText.
	view edges
		fromRightCenter;
		toLeftCenter;
		shape: [ :x | BlLineElement new border: (BlBorder paint: (Color lightGray alpha: 0.4)) ];
		connectFrom: [ :x | x // 2 ].
	view layout horizontalTree horizontalGap: 40.
	^ view