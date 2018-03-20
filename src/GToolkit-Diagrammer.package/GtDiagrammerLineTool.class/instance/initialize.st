initialization
initialize
	super initialize.
	
	overlay := BlOverlayElement new.
	overlay border: (BlBorder paint: (Color blue alpha: 0.1) width: 5)