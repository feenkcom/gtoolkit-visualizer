Class {
	#name : #GtGraphEdgeDrivenLayout,
	#superclass : #GtGraphLayout,
	#instVars : [
		'edges',
		'userDefinedEdges',
		'fromPositions',
		'toPositions',
		'shouldSetDefaultAttachPoint'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Layouts'
}

{ #category : #testing }
GtGraphEdgeDrivenLayout class >> isAbstract [
	^ self = GtGraphEdgeDrivenLayout
]

{ #category : #'default attach points' }
GtGraphEdgeDrivenLayout >> addDefaultAttachPointToEdges [
	self flag: 'Model attach points'.
	
	"edges do: [ :e | e shape attachPoint: self defaultAttachPoint ]"
]

{ #category : #'default attach points' }
GtGraphEdgeDrivenLayout >> defaultAttachPoint [
	self flag: 'Model attach points'.
	
	^ nil
	"^ RTCenteredAttachPoint instance"
]

{ #category : #'default values' }
GtGraphEdgeDrivenLayout >> defaultFromPositions [
	^ #()
	
]

{ #category : #'default values' }
GtGraphEdgeDrivenLayout >> defaultToPositions [
	^ #()

]

{ #category : #'default attach points' }
GtGraphEdgeDrivenLayout >> doAttachPoint [
	"Change the attach point of edges when added"
	shouldSetDefaultAttachPoint := true
]

{ #category : #hook }
GtGraphEdgeDrivenLayout >> doExecute: elements with: anExtentSpec [
	
	self subclassResponsibility
]

{ #category : #'default attach points' }
GtGraphEdgeDrivenLayout >> doNotAttachPoint [
	"Do not add an attach point to edges"
	shouldSetDefaultAttachPoint := false
]

{ #category : #private }
GtGraphEdgeDrivenLayout >> edges [
	
	^ edges
]

{ #category : #accessing }
GtGraphEdgeDrivenLayout >> edges: aCollection [
	edges := aCollection asOrderedCollection.
	self shouldSetDefaultAttachPoint
		ifTrue: [ self addDefaultAttachPointToEdges ]
]

{ #category : #iterator }
GtGraphEdgeDrivenLayout >> edgesDo: aBlock [
	"Iterates over all the edges of the receiver."
	
	edges ifNil: [ ^ self ].
	edges do: aBlock

]

{ #category : #hook }
GtGraphEdgeDrivenLayout >> executeOnElements: elements with: anExtentSpec [
	"Execute the layout, myself, on the elements"

	self setEdgesFromElements: elements.

	super executeOnElements: elements with: anExtentSpec
]

{ #category : #private }
GtGraphEdgeDrivenLayout >> fromPositions [
	
	^fromPositions ifNil: [fromPositions := self defaultFromPositions]
]

{ #category : #accessing }
GtGraphEdgeDrivenLayout >> fromPositions: anArray [
	
	fromPositions := anArray
]

{ #category : #'initialize-release' }
GtGraphEdgeDrivenLayout >> initialize [
	"Initialization"
	super initialize.
	edges := nil.
	shouldSetDefaultAttachPoint := false
]

{ #category : #testing }
GtGraphEdgeDrivenLayout >> isLineLayout [
	^ false
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

{ #category : #'default attach points' }
GtGraphEdgeDrivenLayout >> shouldSetDefaultAttachPoint [
	"Return true if an attach point has to be added to edges. False else"
	^ shouldSetDefaultAttachPoint
]
