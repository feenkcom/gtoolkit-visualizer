api - geometry
reversedPositionOfNode: aTreeNode rootPosition: theRootPosition bounds: theBounds
"calculate position of the node so that it the node is flipped
over a vertical line containing the root node"
	| nodePosition |
	nodePosition := aTreeNode element constraints gradTree computedPosition.

	^ ( 2 * (theRootPosition x) - nodePosition  x + theBounds x) @ (nodePosition y)