"
I am a utility class that offers an extra API for adding graph semantics to Bloc elements 
"
Class {
	#name : #GtGraphElement,
	#superclass : #Object,
	#instVars : [
		'element',
		'isEdge',
		'isNode',
		'model',
		'objectsToNodesCache'
	],
	#category : #'GToolkit-BlocGraph'
}

{ #category : #'instance creation' }
GtGraphElement class >> on: anElement [
	^ self new 
		element: anElement;
		yourself
]

{ #category : #deprecated }
GtGraphElement >> addChildren: aCollection inChildrenContainer: aSymbol [ 
	^ ((self childrenContainers) at: aSymbol ifAbsent: [self element]) addChildren: aCollection
]

{ #category : #deprecated }
GtGraphElement >> beChildrenContainer [
	self beChildrenContainer: #default
]

{ #category : #deprecated }
GtGraphElement >> beChildrenContainer: aSymbol [
	self userData at: #isMondrianChildrenContainer put: aSymbol
]

{ #category : #api }
GtGraphElement >> beEdge [
	isEdge := true.
	isNode := false
]

{ #category : #api }
GtGraphElement >> beNode [
	isEdge := false.
	isNode := true
]

{ #category : #deprecated }
GtGraphElement >> childrenContainerName [
	^ self userData at: #isMondrianChildrenContainer
]

{ #category : #deprecated }
GtGraphElement >> childrenContainerNamed: aSymbol [
	^ self childrenContainers at: aSymbol
]

{ #category : #deprecated }
GtGraphElement >> childrenContainers [
	^ self userData 
		at: #mondrianChildrenContainers
		ifAbsentPut: [ Dictionary new ]
]

{ #category : #'api - graph' }
GtGraphElement >> connectedEdges [
	<return: #GtGraphConnectedEdges>

	^ GtGraphConnectedEdges on: self
]

{ #category : #'api - graph' }
GtGraphElement >> connectedNodes [
	<return: #GtGraphConnectedNodes>

	^ self connectedEdges nodes
]

{ #category : #'api - graph' }
GtGraphElement >> connectedNodesCount [
	<return: #Number>

	^ self connectedNodes size
]

{ #category : #'api - children' }
GtGraphElement >> edgeChildren [
	^ self element children select: [ :each | each graph isEdge ]
]

{ #category : #accessing }
GtGraphElement >> element [
	<return: #BlElement>

	^ element
]

{ #category : #accessing }
GtGraphElement >> element: anElement [
	element := anElement
]

{ #category : #'api - graph' }
GtGraphElement >> hasNodesAlongIncomingEdges [
	<return: #Boolean>

	^ self nodesAlongIncomingEdges isNotEmpty
]

{ #category : #'api - graph' }
GtGraphElement >> hasNodesAlongOutgoingEdges [
	<return: #Boolean>

	^ self nodesAlongOutgoingEdges isNotEmpty
]

{ #category : #deprecated }
GtGraphElement >> identifyChildrenContainers [
	| childrenContainers |
	childrenContainers := Dictionary new.
	self element
		allChildrenBreadthFirstDo: [ :each | 
			each graph isChildrenContainer ifTrue: [ 
				childrenContainers at: each graph childrenContainerName put: each ] ].
	childrenContainers isEmpty ifTrue: [ 
		childrenContainers at: #default put: self element ].
	self userData at: #mondrianChildrenContainers put: childrenContainers
]

{ #category : #initialization }
GtGraphElement >> initialize [
	super initialize.
	
	isEdge := false.
	isNode := false.
	objectsToNodesCache := Dictionary new
]

{ #category : #deprecated }
GtGraphElement >> isChildrenContainer [
	"this property marks an element for being a container of children within the Mondrian context.
	it is useful in the following Mondrian context:
		1. the developer first describes the shape of a node
		2. and then adds children to the node.
	when adding the shape, which is can be a complicated element, the developer can mark the sub-element
	that can contain children, and this information will be taken into account when adding
	the children to the node."
	^ self userData at: #isMondrianChildrenContainer 
		ifPresent: [ :name | true ]
		ifAbsent: [ false ]
]

{ #category : #'api - testing' }
GtGraphElement >> isEdge [
	^ isEdge
]

{ #category : #'api - testing' }
GtGraphElement >> isNode [
	^ isNode
]

{ #category : #api }
GtGraphElement >> model [
	^ model
]

{ #category : #api }
GtGraphElement >> model: anObject [
	model := anObject
]

{ #category : #accessing }
GtGraphElement >> nodeAt: anObject ifAbsent: aBlock [
	^ self 
		nodeAt: anObject 
		ifPresent: [ :aNode | ^ aNode ]
		ifAbsent: aBlock
]

{ #category : #accessing }
GtGraphElement >> nodeAt: anObject ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	objectsToNodesCache
		at: anObject 
		ifPresent: aPresentBlock
		ifAbsent: [
			objectsToNodesCache values notEmpty
				ifTrue: [ 
					objectsToNodesCache values do: [ :aChildNode |
						aChildNode graph
							nodeAt: anObject 
							ifPresent: [ :aNode | 
								^ aPresentBlock value: aNode ] 
							ifAbsent: [ ].
					^ anAbsentBlock value ] ]
				ifFalse: anAbsentBlock ]
]

{ #category : #accessing }
GtGraphElement >> nodeAt: anObject put: aNodeElement [
	^ objectsToNodesCache at: anObject put: aNodeElement
]

{ #category : #'api - children' }
GtGraphElement >> nodeChildren [
	^ self element children select: [ :each | each graph isNode ]
]

{ #category : #'api - graph' }
GtGraphElement >> nodesAlongIncomingEdges [
	<return: #GtGraphConnectedNodes>

	^ self connectedEdges incoming nodes
]

{ #category : #'api - graph' }
GtGraphElement >> nodesAlongIncomingEdgesCount [
	<return: #Number>

	^ self nodesAlongIncomingEdges size
]

{ #category : #'api - graph' }
GtGraphElement >> nodesAlongOutgoingEdges [
	<return: #GtGraphConnectedNodes>

	^ self connectedEdges outgoing nodes
]

{ #category : #'api - graph' }
GtGraphElement >> nodesAlongOutgoingEdgesCount [
	<return: #Number>

	^ self nodesAlongOutgoingEdges size
]

{ #category : #accessing }
GtGraphElement >> userData [
	^ self element userData
]
