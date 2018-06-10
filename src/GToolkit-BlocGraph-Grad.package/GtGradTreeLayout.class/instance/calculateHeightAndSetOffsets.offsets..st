calculating
calculateHeightAndSetOffsets: aNode offsets: offsetsDictionary
	
	| sum prev |
	sum := 0.
	
	prev := nil.
	(self childrenNodes: aNode) do: [ :child |
			sum := sum + child measuredBounds width + (2 * self nodeDistance).
			(prev isNotNil)
				ifTrue: [ 
					offsetsDictionary at: child put: 0@(prev measuredBounds width + (2 * self nodeDistance)).
			].
			prev := child.
		 ].

	^ sum.
