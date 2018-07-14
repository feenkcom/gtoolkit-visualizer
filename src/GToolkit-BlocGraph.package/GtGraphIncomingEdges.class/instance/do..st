api - enumeration
do: aBlock
	"Evaluate a given block with all incoming edges to the graph element"

	self graphElement element constraints graph connectedEdges do: [ :aGtGraphEdge |
		(aGtGraphEdge toElement = self graphElement element)
			ifTrue: [ aBlock value: aGtGraphEdge ] ]