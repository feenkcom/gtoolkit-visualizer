private
defaultEdgeElement
	^ BlLineElement new
		border: (BlBorder paint: (Color gray alpha: 0.5) width: 1);
		wantsMouse: false