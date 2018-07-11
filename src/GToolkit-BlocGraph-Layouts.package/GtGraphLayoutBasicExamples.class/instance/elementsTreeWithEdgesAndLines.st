as yet unclassified
elementsTreeWithEdgesAndLines
	<gtExample>
	| root elementToVisualize |
	root := self elementsTreeWithEdges.
	elementToVisualize := root userData at: #model.
	elementToVisualize allChildrenBreadthFirstDo: [ :each | 
		| label |
		label := root children detect: [ :child | (child userData at: #model) = each ] ifNone: []. 
		root children 
			detect: [ :child | (child userData at: #model) = each parent ]
			ifFound: [ :parentLabel |
				| line |
				line := BlLineElement new.
				line constraints ignoreByLayout.
				line
					border: (BlBorder paint: (Color gray alpha: 0.2) width: 5);
					fromAnchor: (BlElementCenterRightAnchor element: parentLabel);
					toAnchor: (BlElementCenterLeftAnchor element: label).
				root addChild: line ] ].
	^ root