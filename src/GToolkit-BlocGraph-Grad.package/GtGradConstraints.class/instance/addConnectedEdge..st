accessing
addConnectedEdge: aGtGraphEdge

	(self connectedEdges includes: aGtGraphEdge) 
		ifFalse: [ self connectedEdges add: aGtGraphEdge ]