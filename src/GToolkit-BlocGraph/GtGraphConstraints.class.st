"
I represent graph constraints and allow users to specify logical connections between graph nodes with the help of attached graph edges
"
Class {
	#name : #GtGraphConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'connectedEdges',
		'radius'
	],
	#category : 'GToolkit-BlocGraph'
}

{ #category : #accessing }
GtGraphConstraints >> addConnectedEdge: anEdge [

	(self connectedEdges includes: anEdge) 
		ifFalse: [ self connectedEdges add: anEdge ]
]

{ #category : #accessing }
GtGraphConstraints >> connectedEdges [
	^ connectedEdges
]

{ #category : #testing }
GtGraphConstraints >> hasConnectedEdge: anEdge [
	"Return true if a given edge is among my connected edges, false otherwise"
	<return: #Boolean>

	^ self connectedEdges includes: anEdge
]

{ #category : #accessing }
GtGraphConstraints >> incomingEdges [
	^ self connectedEdges select: [ :e | e toElement constraints graph == self ]
]

{ #category : #'initialize-release' }
GtGraphConstraints >> initialize [
	super initialize.
	
	connectedEdges := OrderedCollection new.
	radius := 0
]

{ #category : #accessing }
GtGraphConstraints >> outgoingEdges [
	^ self connectedEdges select: [ :e | e fromElement constraints == self ]
]

{ #category : #accessing }
GtGraphConstraints >> radius [
	^ radius
]

{ #category : #accessing }
GtGraphConstraints >> radius: aNumber [
	radius := aNumber
]

{ #category : #accessing }
GtGraphConstraints >> removeConnectedEdge: anEdge [

	self connectedEdges remove: anEdge ifAbsent: [ "Some tests failed." ]
]
