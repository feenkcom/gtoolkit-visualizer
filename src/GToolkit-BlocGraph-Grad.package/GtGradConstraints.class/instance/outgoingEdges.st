accessing
outgoingEdges
	<return: #Collection of: #GtGraphEdge>

	^ self connectedEdges select: [ :anEdge | anEdge fromElement constraints == self ]