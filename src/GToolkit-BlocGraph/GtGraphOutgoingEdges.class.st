"
I iterate over all outgoing edges from the graph node

```
	| anElement theOutgoingEdges |
	
	anElement := BlElement new.
	theOutgoingEdges := anElement graph connectedEdges outgoing
```


"
Class {
	#name : #GtGraphOutgoingEdges,
	#superclass : #GtGraphEdgesIterator,
	#category : #'GToolkit-BlocGraph-Core'
}

{ #category : #'api - enumeration' }
GtGraphOutgoingEdges >> do: aBlock [
	"Evaluate a given block with all outgoing edges to the graph element"

	self graphElement element constraints graph connectedEdges do: [ :aGtGraphEdge |
		(aGtGraphEdge fromElement = self graphElement element)
			ifTrue: [ aBlock value: aGtGraphEdge ] ]
]
