api - geometry
reversedPositionOfNode: aTreeNode rootPosition: theRootPosition bounds: theBounds
"calculate position of the node so that it the node is flipped
over a horizontal line containing the root node"
	| nodePosition |
	
	nodePosition := aTreeNode element constraints gradTree computedPosition.

	^ (nodePosition x) @ ( 2 * (theRootPosition y) - (nodePosition  y) + (theBounds y)).
	
	

