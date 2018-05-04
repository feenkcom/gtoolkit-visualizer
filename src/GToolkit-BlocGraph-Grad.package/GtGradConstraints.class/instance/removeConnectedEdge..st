accessing
removeConnectedEdge: aGtGraphEdge

	self connectedEdges remove: aGtGraphEdge ifAbsent: [ "Some tests failed." ]