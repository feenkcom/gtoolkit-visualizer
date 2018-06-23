examples - instance creation
rectangle
	<gtExample>

	^ BlElement new
		background: (Color random alpha: 0.4);
		size: self nodeExtent