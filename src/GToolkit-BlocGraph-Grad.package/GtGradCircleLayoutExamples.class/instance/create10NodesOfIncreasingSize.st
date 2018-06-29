examples - composite
create10NodesOfIncreasingSize
	<gtExample>


	^ 10 timesCollect: [ :index |
		| anElement |
		anElement := BlElement new
							background: (Color gray alpha: 0.5);
							border: (BlBorder builder width: 1; paint: Color black) build;
							geometry: BlEllipse new;
							size: 10 asPoint * index.
		anElement graph beNode.
		anElement ]