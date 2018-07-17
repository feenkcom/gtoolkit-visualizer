private - contrours
layoutLeaf: aNodeElement
	| leafCountour nodeHeight nodeWidth distance|
	
	nodeHeight := aNodeElement measuredBounds height.
	nodeWidth := aNodeElement measuredBounds width.
	distance := 2 * self nodeDistance.
	
	leafCountour := GtGradNodeContour new.
	leafCountour upperTail: (GtGradNodeContourLine new position: (nodeHeight + distance)@0).
	leafCountour upperHead: (leafCountour upperTail).
	leafCountour lowerTail: (GtGradNodeContourLine new position: 0@(nodeWidth negated - distance)).
	leafCountour lowerHead: (GtGradNodeContourLine new position: (nodeHeight + distance)@0).
	leafCountour lowerHead next: leafCountour lowerTail.

	aNodeElement constraints gradTree computedContour: leafCountour