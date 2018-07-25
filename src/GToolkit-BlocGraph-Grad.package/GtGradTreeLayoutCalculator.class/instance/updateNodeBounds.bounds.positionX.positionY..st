private - layout
"protocol: #'private - layout'"

updateNodeBounds: aTreeNode bounds: bounds positionX: positionX positionY: positionY
	| nodeWidth nodeHeight  |
	
	nodeWidth := (aTreeNode width) / 2.
	nodeHeight := (aTreeNode height) /2.
	
	(positionX + nodeWidth) > (bounds right)
		ifTrue: [ bounds right: positionX + nodeWidth ].
		
	(positionX - nodeWidth) < (bounds left)
		ifTrue: [ bounds left: positionX - nodeWidth ].

	(positionY + nodeHeight) > (bounds bottom)
		ifTrue: [ bounds bottom: positionY + nodeHeight ].

	(positionY - nodeHeight) <  (bounds top)
		ifTrue: [ bounds top: positionY - nodeHeight ].
