instance creation
resizable
	<gtExample>
	
	^ BlElement new
		size: self initialExtent;
		background: (Color red alpha: 0.5)