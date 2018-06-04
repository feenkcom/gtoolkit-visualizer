examples - instance creation
rectangle
	<gtExample>

	^ BlElement new
		background: (Color random alpha: 0.2);
		size: self nodeExtent