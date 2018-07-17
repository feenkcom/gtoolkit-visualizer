visiting
visitLeafNode: aTreeNode
	| leafCountour nodeHeight nodeWidth distance|

	nodeHeight := aTreeNode height.
	nodeWidth := aTreeNode width.
	distance := 2 * self nodeDistance.

	leafCountour := GtGradNodeContour new.
	leafCountour upperTail: (GtGradNodeContourLine new position: (nodeHeight + distance)@0).
	leafCountour upperHead: (leafCountour upperTail).
	leafCountour lowerTail: (GtGradNodeContourLine new position: 0@(nodeWidth negated - distance)).
	leafCountour lowerHead: (GtGradNodeContourLine new position: (nodeHeight + distance)@0).
	leafCountour lowerHead next: leafCountour lowerTail.

	aTreeNode element constraints gradTree computedContour: leafCountour