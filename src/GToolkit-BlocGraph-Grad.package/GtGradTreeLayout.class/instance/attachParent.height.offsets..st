calculating
attachParent: aNode height: aNumber offsets: offsetsDictionary
	
	| x y1 y2 |
	x := self nodeDistance + self levelDistance.
	y2 := ((aNumber - aNode measuredBounds width) / 2) - self nodeDistance.
	y1 := (y2 + aNode measuredBounds width) + (2 * self nodeDistance ) - aNumber.
	offsetsDictionary at: (self firstChildNode: aNode) put: (x + aNode measuredBounds height)@y1.
	
		
