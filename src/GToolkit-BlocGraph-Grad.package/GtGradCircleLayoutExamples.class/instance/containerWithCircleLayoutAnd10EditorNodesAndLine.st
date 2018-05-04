examples - composite
containerWithCircleLayoutAnd10EditorNodesAndLine
	<gtExample>
	<label: 'An example of a passive edge that is not taking into account by the layout'>
	| aContainer fromNode toNode aLine |
	
	aContainer := self containerWithCircleLayoutAnd10EditorNodes.
	
	fromNode := aContainer children first.
	toNode := aContainer children at: (aContainer children size // 2).
	
	aLine := self line.
	aLine fromAnchor: (BlElementCenterAnchor element: fromNode).
	aLine toAnchor: (BlElementCenterAnchor element: toNode).

	aContainer addChild: aLine.

	^ aContainer