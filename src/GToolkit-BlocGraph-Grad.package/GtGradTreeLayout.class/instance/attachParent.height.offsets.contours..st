calculating
attachParent: aNode height: aNumber offsets: offsetsDictionary contours: aCountoursDict
	
	| x y1 y2 offset newUpperHead newUpperHeadNext newLowerHead newLowerHeadNext|
	x := self nodeDistance + self levelDistance.
	y2 := ((aNumber - aNode measuredBounds width) / 2) - self nodeDistance.
	y1 := (y2 + aNode measuredBounds width) + (2 * self nodeDistance ) - aNumber.
	offset := (x + aNode measuredBounds height)@y1.
	offsetsDictionary at: (aNode graph firstConnectedNodeAlongOutgoingEdge) put: offset.
	
	newUpperHead := NodeContourLine new: (aNode measuredBounds height)@0.
	newUpperHeadNext := (NodeContourLine new: x@y1) next: (aCountoursDict at: aNode) upperHead.
	newUpperHead next: newUpperHeadNext.
	
	newLowerHead := NodeContourLine new: (aNode measuredBounds height)@0.
	newLowerHeadNext := (NodeContourLine new: x@y2) next: (aCountoursDict at: aNode) lowerHead.
	newLowerHead next: newLowerHeadNext.
	
	
	
		
