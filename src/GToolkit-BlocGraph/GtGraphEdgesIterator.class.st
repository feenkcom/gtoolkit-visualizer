"
I am an abstract iterator over edges connected to a graph element
"
Class {
	#name : #GtGraphEdgesIterator,
	#superclass : #GtGraphIterator,
	#category : #'GToolkit-BlocGraph-Core'
}

{ #category : #'api - enumeration' }
GtGraphEdgesIterator >> do: aBlock [
	"Evaluate a given block with all iterator items"
	
	^ self subclassResponsibility
]

{ #category : #'api - iterator' }
GtGraphEdgesIterator >> nodes [
	^ GtGraphConnectedNodes on: self graphElement from: self
]
