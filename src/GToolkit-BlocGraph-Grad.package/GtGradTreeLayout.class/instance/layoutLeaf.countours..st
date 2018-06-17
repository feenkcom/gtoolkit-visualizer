calculating
layoutLeaf: aNode countours: aCountoursDict
	| leafCountour nodeHeight nodeWidth distance|
	
	nodeHeight := aNode measuredBounds height.
	nodeWidth := aNode measuredBounds width.
	distance := 2 * self nodeDistance.
	leafCountour := NodeContour new.
	
	leafCountour upperTail: (NodeContourLine new position: (nodeHeight + distance)@0).
	leafCountour upperHead: (leafCountour upperTail).
	leafCountour lowerTail: (NodeContourLine new position: 0@(0-nodeWidth - distance)).
	leafCountour lowerHead: (NodeContourLine new position: (nodeHeight + distance)@0).
	leafCountour lowerHead next: leafCountour lowerTail.
	
	aCountoursDict at: aNode put: leafCountour.
