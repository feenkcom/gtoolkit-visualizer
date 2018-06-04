calculating
attachParent: aNode height: aNumber offsets: offsetsDictionary
	
	| x y2 y1 |
	x := self nodeDistance + self levelDistance.
	y2 := ((aNumber - aNode measuredBounds width) / 2) - self nodeDistance.
	y1 := (y2 + aNode measuredBounds width) + (2 * self nodeDistance ) - aNumber.
	offsetsDictionary at: (aNode firstChild) put: (x + aNode measuredBounds height)
	
		
