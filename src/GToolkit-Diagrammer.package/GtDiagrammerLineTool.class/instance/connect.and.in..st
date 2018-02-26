connecting
connect: aFromElement and: aToElement in: aContainerElement
	| aLine |
	
	aLine := BlLineElement new.
	aLine border: (BlBorder paint: (Color gray alpha: 0.5) width: 5).
	
	aLine fromAnchor: (BlElementCenterAnchor element: aFromElement).
	aLine toAnchor: (BlElementCenterAnchor element: aToElement).

	aContainerElement addChild: aLine