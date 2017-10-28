adding
addProjection: aGtPlotterAxisProjection
	"Add a projection"
	
	self
		assert: [ aGtPlotterAxisProjection source == self ]
		description: [ 'Can not add not my projection' ].
	
	self projections at: aGtPlotterAxisProjection axis put: aGtPlotterAxisProjection