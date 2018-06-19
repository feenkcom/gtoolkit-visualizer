calculating
attachParent: aNode height: aNumber offsets: offsetsDictionary
	
	| x y1 y2 offset upperHead lowerHead|
	x := self nodeDistance + self levelDistance.
	y2 := ((aNumber - aNode measuredBounds width) / 2) - self nodeDistance.
	y1 := (y2 + aNode measuredBounds width) + (2 * self nodeDistance ) - aNumber.
	offset := (x + aNode measuredBounds height)@y1.
	offsetsDictionary at: (aNode graph firstConnectedNodeAlongOutgoingEdge) put: offset
	

		
		
