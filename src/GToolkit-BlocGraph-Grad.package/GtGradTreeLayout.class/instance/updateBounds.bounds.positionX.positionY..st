calculating
updateBounds: aNodeElement bounds: bounds positionX: positionX positionY: positionY

	| nodeWidth nodeHeight newX newY |
	
	nodeHeight := aNodeElement measuredBounds height.
	nodeWidth := aNodeElement measuredBounds width.
	
	newX := bounds x.
	newY := bounds y.
	
	(positionX + nodeWidth) > (bounds x)
		ifTrue: [ newX := positionX + nodeWidth ].

	(positionY + nodeHeight) > (bounds y)
		ifTrue: [ newY := positionY + nodeHeight ].

	^ newX@newY.