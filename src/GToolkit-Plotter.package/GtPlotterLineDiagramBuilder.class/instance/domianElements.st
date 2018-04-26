private - accessing
domianElements
	<return: #Collection of: #BlElement>

	^ self topStep root children select: [ :aChildElement | aChildElement constraints plotter hasDomainObject ]