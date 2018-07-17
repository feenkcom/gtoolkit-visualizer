private - layout
attachParent: aTreeNode height: height
	| x y1 y2 offset nodeContour previousUpperHead previousLowerHead upperHeadNext lowerHeadNext |

	x := self nodeDistance + self levelDistance.
	y2 := ((height - aTreeNode width) / 2) - self nodeDistance.
	y1 := (y2 + aTreeNode width) + (2 * self nodeDistance) - height.

	offset := (x + aTreeNode height)@y1.

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
		
