calculating
calculateHeightAndSetOffsets: aNode offsets: offsetsDictionary
	
	| sum prev |
	sum := 0.
	
	prev := nil.
	(aNode children ) do: [ :each |
			sum := sum + each measuredBounds width + (2 * self nodeDistance).
			(prev isNotNil)
				ifTrue: [ 
					offsetsDictionary at: each put: 0@(prev measuredBounds width + (2 * self nodeDistance)).
			].
		 ].
	^ sum.
