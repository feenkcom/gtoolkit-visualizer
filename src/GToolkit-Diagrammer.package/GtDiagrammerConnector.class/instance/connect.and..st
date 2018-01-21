connecting
connect: aFromElement and: aToElement
	| aLine |
	
	aLine := BlLineElement new.
	aLine border: (BlBorder paint: (Color gray alpha: 0.5) width: 2).
	
	aLine fromAnchor: (BlElementCenterAnchor element: aFromElement).
	aLine toAnchor: (BlElementCenterAnchor element: aToElement).

	self canvas addChild: aLine