"
I iterate over all connected edges of the graph element.

Users can ask for different subsets of those edges for example incoming or outgoing edges
"
Class {
	#name : #GtGraphConnectedEdges,
	#superclass : #GtGraphEdgesIterator,
	#category : 'GToolkit-BlocGraph'
}

{ #category : #'api - enumeration' }
GtGraphConnectedEdges >> do: aBlock [
	"Evaluate a given block with all connected edges of the graph element"
	
	self graphElement element constraints graph connectedEdges do: aBlock
]

{ #category : #'api - iterator' }
GtGraphConnectedEdges >> incoming [
	^ GtGraphIncomingEdges on: self graphElement
]

{ #category : #'api - iterator' }
GtGraphConnectedEdges >> outgoing [
	^ GtGraphOutgoingEdges on: self graphElement
]
