computation
projections: aCollectionOfDomainValues
	<return: #SequenceableCollection of: #GtPlotterAxisProjection>

	^ aCollectionOfDomainValues
		collectWithIndex: [ :aDomainObject :anIndex | self projection: aDomainObject at: anIndex ]