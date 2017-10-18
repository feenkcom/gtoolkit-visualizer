accessing
axis
	<return: #GtPlotterAxis>

	self
		assert: [ axis isNotNil ]
		description: [ 'Can not access axis if an element does not represent it' ].

	^ axis