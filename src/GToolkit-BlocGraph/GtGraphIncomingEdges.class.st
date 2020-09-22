"
I iterate over all incoming edges to the graph node

[[[
	| anElement theIncomingEdges |
	
	anElement := BlElement new.
	theIncomingEdges := anElement graph connectedEdges incoming
]]]
"
Class {
	#name : #GtGraphIncomingEdges,
	#superclass : #GtGraphEdgesIterator,
	#category : #'GToolkit-BlocGraph-Core'
}

{ #category : #'api - enumeration' }
GtGraphIncomingEdges >> do: aBlock [
	"Evaluate a given block with all incoming edges to the graph element"

	self graphElement element constraints graph connectedEdges do: [ :aGtGraphEdge |
		(aGtGraphEdge toElement = self graphElement element)
			ifTrue: [ aBlock value: aGtGraphEdge ] ]
]
