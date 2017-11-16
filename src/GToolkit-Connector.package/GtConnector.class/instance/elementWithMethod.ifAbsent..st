search
elementWithMethod: aMethod ifAbsent: aBlock
	
	self
		elementWithMethod: aMethod
		ifPresent: [ :anElement | ^ anElement ].
		
	^ aBlock value