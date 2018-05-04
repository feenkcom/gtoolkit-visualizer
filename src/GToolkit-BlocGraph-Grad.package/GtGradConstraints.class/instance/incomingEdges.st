accessing
incomingEdges
	<return: #Collection of: #GtGraphEdge>

	^ self connectedEdges select: [ :anEdge | anEdge toElement constraints graph == self ]