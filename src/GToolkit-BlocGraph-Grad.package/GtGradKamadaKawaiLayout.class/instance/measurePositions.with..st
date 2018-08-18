measure
measurePositions: anElement with: anExtentSpec
	| theNodes |
	
	theNodes := anElement children accountedByLayout
		select: [ :aChildElement | aChildElement graph isNode ].
			
	self initializeLayout: theNodes.
	self layout: theNodes.

	theNodes do: [ :aNodeElement |
		aNodeElement measuredBounds position: (aNodeElement constraints gradKamadaKawai computedPosition) ]