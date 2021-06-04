"
I iterate over all nodes connected by given edges to the initial graph  element


"
Class {
	#name : #GtGraphConnectedNodes,
	#superclass : #GtGraphIterator,
	#instVars : [
		'edges'
	],
	#category : #'GToolkit-BlocGraph-Core'
}

{ #category : #'instance creation' }
GtGraphConnectedNodes class >> on: aGtGraphElement from: theEdges [
	^ (self on: aGtGraphElement) initializeWith: theEdges
]

{ #category : #'api - enumeration' }
GtGraphConnectedNodes >> do: aBlock [
	edges do: [ :aGtGraphEdge |
		"we don't want to include a node from which we asked for edges"
		(aGtGraphEdge fromElement ~= self graphElement element)
			ifTrue: [ aBlock value: aGtGraphEdge fromElement ].
		(aGtGraphEdge toElement ~= self graphElement element)
			ifTrue: [ aBlock value: aGtGraphEdge toElement ] ]
]

{ #category : #initialization }
GtGraphConnectedNodes >> initializeWith: theEdges [
	edges := theEdges
]
