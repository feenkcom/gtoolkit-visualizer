accessing
outgoingEdges
	^ self connectedEdges select: [ :e | e fromElement constraints == self ]