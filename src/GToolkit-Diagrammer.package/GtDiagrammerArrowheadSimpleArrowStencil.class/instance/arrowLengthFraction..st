accessing
arrowLengthFraction: aNumber
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Length must not be nil' ].

	self
		assert: [ aNumber >= 0 ]
		description: [ 'Arrow length must not be negative' ].

	arrowLengthFraction := aNumber