private - layout
updateNodeBounds: aTreeNode bounds: bounds positionX: positionX positionY: positionY
	| nodeWidth nodeHeight newX newY |
	
	nodeWidth := aTreeNode width.
	nodeHeight := aTreeNode height.
	
	newX := bounds x.
	newY := bounds y.
	
	(positionX + nodeWidth) > (bounds x)
		ifTrue: [ newX := positionX + nodeWidth ].

	(positionY + nodeHeight) > (bounds y)
		ifTrue: [ newY := positionY + nodeHeight ].

	^ newX @ newY