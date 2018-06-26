accessing
outgoingEdges
	self flag: 'this check is not necessary because you initialze the variable with a collection'.
	connectedEdges ifNil: [ ^ #() ].
	^ self connectedEdges select: [ :e | e fromElement constraints == self ]