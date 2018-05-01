accessing
incomingEdges
	^ self connectedEdges select: [ :e | e toElement constraints graph == self ]