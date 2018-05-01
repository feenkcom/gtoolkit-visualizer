as yet unclassified
elementsTreeWithEdges
	<gtExample>
	| elementToVisualize root |
	elementToVisualize := BlChicken chicken.
	elementToVisualize forceLayout.
	root := BlElement new constraintsDo: [:c | 
		c horizontal matchParent. c vertical matchParent].
	root userData at: #model put: elementToVisualize.
	elementToVisualize allChildrenBreadthFirstDo: [ :each | 
		| label |
		label := BlTextElement new
			text: each gtDisplayString asRopedText;
			background: Color white;
			effect: (BlDropShadowEffect color: (Color gray alpha: 0.5) width: 10 offset: 0@0).
		label userData at: #model put: each.
		root children 
			detect: [ :child | 
				(child userData at: #model ifAbsent: [ nil ]) = each parent ]
			ifFound: [ :parentLabel |
				| edge |
				edge := GtGraphEdge new from: parentLabel to: label.
				parentLabel constraints graph addConnectedEdge: edge.
				label constraints graph addConnectedEdge: edge ].
		root addChild: label].
	root layout: (GtGraphHorizontalTreeLayout new layered; verticalGap: 20).
	^ root 