calculating
layoutLeaf: aNodeElement countours: aCountoursDict
	| leafCountour nodeHeight nodeWidth distance|
	
	nodeHeight := aNodeElement measuredBounds height.
	nodeWidth := aNodeElement measuredBounds width.
	distance := 2 * self nodeDistance.
	
	leafCountour := NodeContour new.
	leafCountour upperTail: (NodeContourLine new position: (nodeHeight + distance)@0).
	leafCountour upperHead: (leafCountour upperTail).
	leafCountour lowerTail: (NodeContourLine new position: 0@(nodeWidth negated - distance)).
	leafCountour lowerHead: (NodeContourLine new position: (nodeHeight + distance)@0).
	leafCountour lowerHead next: leafCountour lowerTail.
	
	aCountoursDict at: aNodeElement put: leafCountour