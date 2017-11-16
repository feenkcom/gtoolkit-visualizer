private - adding / removing
removeEdgeFrom: aSourceElement to: aTargetElement
	"I remove edges associated with the given element and edges from other elements with which it is connected"

	aSourceElement constraints graph outgoingEdges
		select: [ :anEdge | anEdge toElement == aTargetElement ]
		thenDo: [ :anEdge |
			aSourceElement constraints graph removeConnectedEdge: anEdge.
			aTargetElement constraints graph removeConnectedEdge: anEdge ].
	self requestLayout