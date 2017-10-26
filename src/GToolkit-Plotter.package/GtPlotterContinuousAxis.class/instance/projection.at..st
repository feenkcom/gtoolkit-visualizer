computation
projection: aDomainObject at: anIndex
	"Return a projection of a given domain object on this axis"
	<return: #GtPlotterAxisProjection>

	^ GtPlotterAxisProjection new value: (self valueSelector value: aDomainObject)