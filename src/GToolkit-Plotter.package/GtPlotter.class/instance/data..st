accessing
data: aCollection
	domainObjects := aCollection collect: [ :each | GtPlotterDomainObject new value: each ]