examples - layout
bigNodesN: num
	<gtExample>
	
	^ num timesCollect: [ :index |
		| aNode |
		aNode := BlElement new
							background: (Color gray alpha: 0.5);
							border: (BlBorder builder width: 1; paint: Color black) build;
							geometry: BlEllipse new;
							size: 300@300.
		aNode graph beNode.
		aNode ]