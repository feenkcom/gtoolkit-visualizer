Class {
	#name : #GtGraphEdgeDrivenLayout,
	#superclass : #GtGraphLayout,
	#instVars : [
		'edges'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Layouts'
}

{ #category : #testing }
GtGraphEdgeDrivenLayout class >> isAbstract [
	^ self = GtGraphEdgeDrivenLayout
]

{ #category : #hook }
GtGraphEdgeDrivenLayout >> doExecute: elements with: anExtentSpec [
	
	self subclassResponsibility
]

{ #category : #private }
GtGraphEdgeDrivenLayout >> edges [
	^ edges
]

{ #category : #accessing }
GtGraphEdgeDrivenLayout >> edges: aCollection [
	edges := aCollection asOrderedCollection
]

{ #category : #iterator }
GtGraphEdgeDrivenLayout >> edgesDo: aBlock [
	"Iterates over all the edges of the receiver."
	edges do: aBlock

]

{ #category : #hook }
GtGraphEdgeDrivenLayout >> executeOnElements: elements with: anExtentSpec [
	"Execute the layout, myself, on the elements"

	self setEdgesFromElements: elements.

	super executeOnElements: elements with: anExtentSpec
]

{ #category : #'initialize-release' }
GtGraphEdgeDrivenLayout >> initialize [
	super initialize.

	edges := OrderedCollection new
]

{ #category : #accessing }
GtGraphEdgeDrivenLayout >> setEdgesFromElements: aCollectionOfLayoutChildNodes [
	| aConstraintsMap theIncomingEdges |
	aCollectionOfLayoutChildNodes isEmpty
		ifTrue: [ ^ self ].

	aConstraintsMap := IdentityDictionary new.
	aCollectionOfLayoutChildNodes
		do: [ :eachNode | aConstraintsMap at: eachNode constraints put: eachNode ].
	theIncomingEdges := Array
		streamContents: [ :aStream | 
			aCollectionOfLayoutChildNodes
				do: [ :eachChildNode | 
					eachChildNode incomingEdges
						do: [ :eachGraphEdge | 
							aStream
								nextPut:
									(BlLayoutEdge new
										fromNode: (aConstraintsMap at: eachGraphEdge fromNode constraints);
										toNode: (aConstraintsMap at: eachGraphEdge toNode constraints)) ] ] ].
	self
		edges:
			(theIncomingEdges
				select:
					[ :eachEdge | aCollectionOfLayoutChildNodes includes: eachEdge fromNode ])
]
