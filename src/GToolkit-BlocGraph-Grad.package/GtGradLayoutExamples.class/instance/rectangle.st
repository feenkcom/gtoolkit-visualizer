accessing
rectangle
	<gtExample>

	^ BlElement new
		background: (Color gray alpha: 0.5);
		border: (BlBorder builder width: 1; paint: Color black) build;
		size: self nodeExtent