testing
hasConnectedEdge: anEdge
	"Return true if a given edge is among my connected edges, false otherwise"
	<return: #Boolean>

	^ self connectedEdges includes: anEdge