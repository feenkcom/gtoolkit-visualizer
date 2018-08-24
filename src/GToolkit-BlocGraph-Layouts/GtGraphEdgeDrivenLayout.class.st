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
	#category : 'GToolkit-BlocGraph-Layouts-Layouts'
}

{ #category : #testing }
GtGraphEdgeDrivenLayout class >> isAbstract [
	^ self = GtGraphEdgeDrivenLayout
]

{ #category : #public }
GtGraphEdgeDrivenLayout class >> on: elements edges: edges [
	^ self new on: elements edges: edges
]

{ #category : #'instance creation' }
GtGraphEdgeDrivenLayout class >> withEdges: aCollection [
	
	^self new initialize userDefinedEdges: aCollection
]

{ #category : #'default attach points' }
GtGraphEdgeDrivenLayout >> addDefaultAttachPointToEdges [
	self flag: 'Model attach points'.
	
	"edges do: [ :e | e shape attachPoint: self defaultAttachPoint ]"
]

{ #category : #accessing }
GtGraphEdgeDrivenLayout >> affectedNodes [
	
	^affectedNodes
]

{ #category : #accessing }
GtGraphEdgeDrivenLayout >> affectedNodes: anObject [
	
	affectedNodes := anObject
]

{ #category : #accessing }
GtGraphEdgeDrivenLayout >> affectedNodesOf:  aNode [ 
	^ affectedNodes ifNil: [ aNode nodes ]
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
GtGraphEdgeDrivenLayout >> doExecute: elements [
	
	self subclassResponsibility
]

{ #category : #hook }
GtGraphEdgeDrivenLayout >> doIncrementallyExecute: anElementNode [
	"called by refreshLayoutEvery: ms. It is used to convey a feeling of incremental execution."
	
	self doExecute: anElementNode
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
GtGraphEdgeDrivenLayout >> executeOnElements: elements [ 
	"Execute the layout, myself, on the elements"

	self userDefinedEdges isNil 
		ifTrue: [ self setEdgesFromElements: elements ]
		ifFalse: 
			[ | flat |
			flat := OrderedCollection new.
			self userDefinedEdges do: 
				[ :each | 
				each isCollection 
					ifTrue: [ flat addAll: each ]
					ifFalse: [ flat add: each ] ].
			self edges: flat ].
		
	super executeOnElements: elements
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
GtGraphEdgeDrivenLayout >> setEdgesFromElements: elements [ 

	elements isEmpty
		ifTrue: [ ^ self ].
	^ self
		edges:
			((elements flatCollect: [ :each | each constraints graph incomingEdges ])
				select: [ :anEdge | (elements includes: anEdge fromElement) ])
]

{ #category : #'default attach points' }
GtGraphEdgeDrivenLayout >> shouldSetDefaultAttachPoint [
	"Return true if an attach point has to be added to edges. False else"
	^ shouldSetDefaultAttachPoint
]

{ #category : #private }
GtGraphEdgeDrivenLayout >> toPositions [
	
	^toPositions ifNil: [toPositions := self defaultToPositions]
]

{ #category : #accessing }
GtGraphEdgeDrivenLayout >> toPositions: anArray [
	
	toPositions := anArray
]

{ #category : #private }
GtGraphEdgeDrivenLayout >> userDefinedEdges [
	
	^userDefinedEdges
]

{ #category : #'initialize-release' }
GtGraphEdgeDrivenLayout >> userDefinedEdges: aCollectionOfEdges [
	"useful to tell to the layout which edges have to be used for the layout"

	userDefinedEdges := aCollectionOfEdges.
	
]
