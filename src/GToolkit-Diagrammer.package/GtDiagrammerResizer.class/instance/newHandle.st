instance creation
newHandle
	^ BlElement new
		background: Color white;
		border: (BlBorder paint: Color gray width: 1);
		size: 6@6