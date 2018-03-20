accessing
arrowNoseAngle: aNumber
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Length must not be nil' ].

	self
		assert: [ aNumber > 0 and: [ aNumber < 180 ] ]
		description: [ 'Arrow length must be within an open interval (0..180)' ].
		
	arrowNoseAngle := aNumber