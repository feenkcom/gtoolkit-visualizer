instance creation
newHandle
	^ BlElement new
		background: (Color white alpha: 0.5);
		border: (BlBorder paint: Color gray width: 1);
		size: 6@6