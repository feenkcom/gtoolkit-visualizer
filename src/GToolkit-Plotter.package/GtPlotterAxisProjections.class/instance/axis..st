accessing
axis: aGtPlotterAxis

	self
		assert: [ axis isNil ]
		description: [ 'Projection axis can not change' ].

	self
		assert: [ aGtPlotterAxis isNotNil ]
		description: [ 'Projection axis must not be nil' ].

	axis := aGtPlotterAxis