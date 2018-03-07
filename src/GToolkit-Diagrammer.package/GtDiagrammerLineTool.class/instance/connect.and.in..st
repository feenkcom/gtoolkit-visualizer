connecting
connect: aFromElement and: aToElement in: aContainerElement
	| aLine |
	
	aLine := BlLineElement new.
	aLine border: (BlBorder paint: (Color gray alpha: 0.5) width: 2).
	
	aLine fromAnchor: (BlNearestPositionEllipseAnchor referenceElement: aFromElement relatedTo: aToElement).
	aLine toAnchor: (BlNearestPositionEllipseAnchor referenceElement: aToElement relatedTo: aFromElement).

	aContainerElement addChild: aLine.
	
	^ aLine