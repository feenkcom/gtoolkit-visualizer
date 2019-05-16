"
I am a utility class that offers an extra API for adding graph semantics to Bloc elements 
"
Class {
	#name : #GtGraphElementContext,
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
GtGraphElementContext class >> on: anElement [
	^ self new 
		element: anElement;
		yourself
]

{ #category : #deprecated }
GtGraphElementContext >> addChildren: aCollection inChildrenContainer: aSymbol [ 
	^ ((self childrenContainers) at: aSymbol ifAbsent: [self element]) addChildren: aCollection
]

{ #category : #deprecated }
GtGraphElementContext >> beChildrenContainer [
	self beChildrenContainer: #default
]

{ #category : #deprecated }
GtGraphElementContext >> beChildrenContainer: aSymbol [
	self userData at: #isMondrianChildrenContainer put: aSymbol
]

{ #category : #api }
GtGraphElementContext >> beEdge [
	isEdge := true.
	isNode := false
]

{ #category : #api }
GtGraphElementContext >> beNode [
	isEdge := false.
	isNode := true
]

{ #category : #deprecated }
GtGraphElementContext >> childrenContainerName [
	^ self userData at: #isMondrianChildrenContainer
]

{ #category : #deprecated }
GtGraphElementContext >> childrenContainerNamed: aSymbol [
	^ self childrenContainers at: aSymbol
]

{ #category : #deprecated }
GtGraphElementContext >> childrenContainers [
	^ self userData 
		at: #mondrianChildrenContainers
		ifAbsentPut: [ Dictionary new ]
]

{ #category : #'api - graph' }
GtGraphElementContext >> connectTo: anotherElement [
	"I connect my element with a given element as an outgoing edge and return
	a new instance of an edge"
	<return: #GtGraphEdge>
	| anEdge |

	anEdge := GtGraphEdge new.
	anEdge from: self element to: anotherElement.

	self element constraints graph addConnectedEdge: anEdge.
	anotherElement constraints graph addConnectedEdge: anEdge.

	self beNode.
	anotherElement graph beNode.

	^ anEdge
]

{ #category : #'api - graph' }
GtGraphElementContext >> connectedEdges [
	<return: #GtGraphConnectedEdges>

	^ GtGraphConnectedEdges on: self
]

{ #category : #'api - graph' }
GtGraphElementContext >> connectedNodes [
	<return: #GtGraphConnectedNodes>

	^ self connectedEdges nodes
]

{ #category : #'api - graph' }
GtGraphElementContext >> connectedNodesCount [
	<return: #Number>

	^ self connectedNodes size
]

{ #category : #'api - children' }
GtGraphElementContext >> edgeChildren [
	^ self element children select: [ :each | each graph isEdge ]
]

{ #category : #accessing }
GtGraphElementContext >> element [
	<return: #BlElement>

	^ element
]

{ #category : #accessing }
GtGraphElementContext >> element: anElement [
	element := anElement
]

{ #category : #accessing }
GtGraphElementContext >> firstNodeParent [
	self isNode ifTrue: [ ^ self element ].
	element parent isNil ifTrue: [ ^ self element ].
	^ element parent graph firstNodeParent
]

{ #category : #'api - graph' }
GtGraphElementContext >> hasNodesAlongIncomingEdges [
	<return: #Boolean>

	^ self nodesAlongIncomingEdges isNotEmpty
]

{ #category : #'api - graph' }
GtGraphElementContext >> hasNodesAlongOutgoingEdges [
	<return: #Boolean>

	^ self nodesAlongOutgoingEdges isNotEmpty
]

{ #category : #deprecated }
GtGraphElementContext >> identifyChildrenContainers [
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
GtGraphElementContext >> initialize [
	super initialize.
	
	isEdge := false.
	isNode := false.
	objectsToNodesCache := Dictionary new
]

{ #category : #deprecated }
GtGraphElementContext >> isChildrenContainer [
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
GtGraphElementContext >> isEdge [
	^ isEdge
]

{ #category : #'api - testing' }
GtGraphElementContext >> isNode [
	^ isNode
]

{ #category : #api }
GtGraphElementContext >> model [
	^ model
]

{ #category : #api }
GtGraphElementContext >> model: anObject [
	model := anObject
]

{ #category : #accessing }
GtGraphElementContext >> nodeAt: anObject ifAbsent: aBlock [
	^ self 
		nodeAt: anObject 
		ifPresent: [ :aNode | ^ aNode ]
		ifAbsent: aBlock
]

{ #category : #accessing }
GtGraphElementContext >> nodeAt: anObject ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	objectsToNodesCache
		at: anObject 
		ifPresent: aPresentBlock
		ifAbsent: [
			objectsToNodesCache values notEmpty
				ifTrue: [ 
					objectsToNodesCache values do: [ :aChildNode |
						aChildNode graph
							nodeAt: anObject 
							ifPresent: [ :aNode | ^ aPresentBlock value: aNode ] 
							ifAbsent: [ ] ].
					^ anAbsentBlock value ]
				ifFalse: anAbsentBlock ]
]

{ #category : #accessing }
GtGraphElementContext >> nodeAt: anObject put: aNodeElement [
	^ objectsToNodesCache at: anObject put: aNodeElement
]

{ #category : #'api - children' }
GtGraphElementContext >> nodeChildren [
	^ self element children select: [ :each | each graph isNode ]
]

{ #category : #'api - graph' }
GtGraphElementContext >> nodesAlongIncomingEdges [
	<return: #GtGraphConnectedNodes>

	^ self connectedEdges incoming nodes
]

{ #category : #'api - graph' }
GtGraphElementContext >> nodesAlongIncomingEdgesCount [
	<return: #Number>

	^ self nodesAlongIncomingEdges size
]

{ #category : #'api - graph' }
GtGraphElementContext >> nodesAlongOutgoingEdges [
	<return: #GtGraphConnectedNodes>

	^ self connectedEdges outgoing nodes
]

{ #category : #'api - graph' }
GtGraphElementContext >> nodesAlongOutgoingEdgesCount [
	<return: #Number>

	^ self nodesAlongOutgoingEdges size
]

{ #category : #accessing }
GtGraphElementContext >> userData [
	^ self element userData
]
