api - enumeration
do: aBlock
	"Evaluate a given block with all outgoing edges to the graph element"

	self graphElement element constraints graph connectedEdges do: [ :aGtGraphEdge |
		(aGtGraphEdge fromElement = self graphElement element)
			ifTrue: [ aBlock value: aGtGraphEdge ] ]