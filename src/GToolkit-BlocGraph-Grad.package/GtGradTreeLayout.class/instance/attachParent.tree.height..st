calculating
attachParent: aNode tree: aDFSTree height: height
	| x y1 y2 offset nodeContour previousUpperHead previousLowerHead upperHeadNext lowerHeadNext |

	x := self nodeDistance + self levelDistance.
	y2 := ((height - aNode measuredBounds width) / 2) - self nodeDistance.
	y1 := (y2 + aNode measuredBounds width) + (2 * self nodeDistance) - height.

	offset := (x + aNode measuredBounds height)@y1.

	self flag: 'use constraints'.
	(aDFSTree at: aNode) first constraints gradTree computedOffset: offset.

	GtGradTreeLayoutOffsetSetSignal new 
		node: aNode; 
		offsetX: offset x; 
		offsetY: offset y;
		emit.

	nodeContour := aNode constraints gradTree computedContour.

	previousUpperHead := nodeContour upperHead.
	nodeContour upperHead: (GtGradNodeContourLine new position: (aNode measuredBounds height)@0).
	upperHeadNext := (GtGradNodeContourLine new position: x@y1) next: previousUpperHead.
	nodeContour upperHead next: upperHeadNext.
	
	previousLowerHead := nodeContour lowerHead.
	nodeContour lowerHead: (GtGradNodeContourLine new position: (aNode measuredBounds height)@0).
	lowerHeadNext := (GtGradNodeContourLine new position: x@y2) next: previousLowerHead.
	nodeContour lowerHead next: lowerHeadNext.

		
