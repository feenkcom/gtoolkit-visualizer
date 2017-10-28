initialization
computeProjections: aCollectionOfDomainObjects
	<return: #GtPlotterAxisProjections>

	^ (GtPlotterAxisProjections streamContents: [ :aStream | 
		aCollectionOfDomainObjects
			doWithIndex: [ :aDomainObject :anIndex |
				| aProjection |
				aProjection := self projection: aDomainObject at: anIndex.
				aProjection source: aDomainObject.
				aProjection axis: self.
				aDomainObject addProjection: aProjection.
				aStream nextPut: aProjection ] ])
			axis: self