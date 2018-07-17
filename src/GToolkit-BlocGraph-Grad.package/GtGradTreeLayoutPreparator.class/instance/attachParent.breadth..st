private - layout
attachParent: aTreeNode breadth: aChildrenBreadth
	| x y1 y2 offset nodeContour previousUpperHead previousLowerHead upperHeadNext lowerHeadNext |

	x := self nodeDistance + self levelDistance.
	
	"here we make sure that the parent is centered relative to its children"
	y2 := ((aChildrenBreadth - (self layout nodeBreadth: aTreeNode)) / 2.0) - self nodeDistance.

	y1 := (y2 + (self layout nodeBreadth: aTreeNode)) + (2 * self nodeDistance) - aChildrenBreadth.

	offset := (x + (self layout nodeLength: aTreeNode))@y1.

	aTreeNode nodes first element constraints gradTree computedOffset: offset.

	GtGradTreeLayoutOffsetSetSignal new 
		node: aTreeNode; 
		offsetX: offset x; 
		offsetY: offset y;
		emit.

	nodeContour := aTreeNode element constraints gradTree computedContour.

	previousUpperHead := nodeContour upperHead.
	nodeContour upperHead: (GtGradNodeContourLine new position: (aTreeNode height)@0).
	upperHeadNext := (GtGradNodeContourLine new position: x@y1) next: previousUpperHead.
	nodeContour upperHead next: upperHeadNext.
	
	previousLowerHead := nodeContour lowerHead.
	nodeContour lowerHead: (GtGradNodeContourLine new position: (aTreeNode height)@0).
	lowerHeadNext := (GtGradNodeContourLine new position: x@y2) next: previousLowerHead.
	nodeContour lowerHead next: lowerHeadNext
		
