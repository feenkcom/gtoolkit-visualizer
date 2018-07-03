accessing
tick
	self
		assert: [ tick isNotNil ]
		description: [ 'Can not access tick if an element does not represent it' ].

	^ tick