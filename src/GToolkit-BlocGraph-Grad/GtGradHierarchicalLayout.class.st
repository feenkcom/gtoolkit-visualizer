Class {
	#name : #GtGradHierarchicalLayout,
	#superclass : #GtGradLayout,
	#instVars : [
		'intraCellSpacing',
		'interRankCellSpacing',
		'interHierarchySpacing',
		'parallelEdgeSpacing',
		'roots',
		'positions'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #constraints }
GtGradHierarchicalLayout class >> constraints [
	^ GtGradHierarchicalConstraints new
]

{ #category : #'private-layout' }
GtGradHierarchicalLayout >> crossingStage: model [
]

{ #category : #'private-layout' }
GtGradHierarchicalLayout >> cycleStage: model [
	| cycleRemover |
	cycleRemover := GtGradHierarchicalCycleRemovalStage new model: model.
	"cycleRemover execute"
]

{ #category : #'private-layout' }
GtGradHierarchicalLayout >> filterDescendants: aNode [
	| descendants |
	
	descendants := Set new.
	aNode = self layoutParent
		ifFalse: [ descendants add: aNode ].
	aNode graph nodesAlongOutgoingEdges do: [ :aChildNode |
		descendants addAll: (self filterDescendants: aChildNode)
	].
	^ descendants

]

{ #category : #'private-layout' }
GtGradHierarchicalLayout >> findRoots: theNodes [
	"""
	Finds all nodes that do not have incoming edges.
	If there are no such nodes, the nodes which has maximum difference
	between the number of incoming and outcoming edges is found
	"""
	| aRootsCollection bestNode maxDiff |
	aRootsCollection := OrderedCollection new.
	bestNode := nil.
	maxDiff := -1.
	theNodes do: [ :theNode |
		| incomingEdgesNum outgoingEdgesNum |
		incomingEdgesNum := theNode graph nodesAlongIncomingEdgesCount.
		outgoingEdgesNum := theNode graph nodesAlongOutgoingEdgesCount.
		(incomingEdgesNum = 0 and: [ outgoingEdgesNum > 0 ])
			ifTrue: [ 
				aRootsCollection add: theNode.
			]
			ifFalse: [ 
				| diff |
				diff := outgoingEdgesNum - incomingEdgesNum.
				diff > maxDiff
					ifTrue: [ 
						maxDiff := diff.
						bestNode := theNode.
					]	
			].
	].
	
	(aRootsCollection isEmpty and: [ bestNode isNotNil ])
		ifTrue: [ 
			aRootsCollection add: bestNode
		].
	^ aRootsCollection
]

{ #category : #initialization }
GtGradHierarchicalLayout >> initialize [
	super initialize.
	intraCellSpacing := 30.
	interRankCellSpacing := 50.
	interHierarchySpacing := 60.
	parallelEdgeSpacing := 10.
	
	
]

{ #category : #accessing }
GtGradHierarchicalLayout >> interHierarchySpacing [
	"Space between unconnected hierarchies"
	^ interHierarchySpacing
]

{ #category : #accessing }
GtGradHierarchicalLayout >> interHierarchySpacing: anObject [
	interHierarchySpacing := anObject
]

{ #category : #accessing }
GtGradHierarchicalLayout >> interRankCellSpacing [
	"Space betweeb cells on adjacent layers"
	^ interRankCellSpacing
]

{ #category : #accessing }
GtGradHierarchicalLayout >> interRankCellSpacing: anObject [
	interRankCellSpacing := anObject
]

{ #category : #accessing }
GtGradHierarchicalLayout >> intraCellSpacing [
	"Space between cells on the same level"
	^ intraCellSpacing
]

{ #category : #accessing }
GtGradHierarchicalLayout >> intraCellSpacing: anObject [
	intraCellSpacing := anObject
]

{ #category : #'private-layout' }
GtGradHierarchicalLayout >> isDescentantOf: childNode parentNode: parentNode [
	^ (parentNode graph nodesAlongOutgoingEdges includes: childNode) or: [	
	  parentNode graph nodesAlongOutgoingEdges
		anySatisfy: [ :aChildNode | self isDescentantOf: childNode parentNode: aChildNode ]]
]

{ #category : #'private-layout' }
GtGradHierarchicalLayout >> layeringStage [
]

{ #category : #measure }
GtGradHierarchicalLayout >> measurePositions: anElement with: anExtentSpec [
	| theNodes |

	theNodes := anElement children accountedByLayout
		select: [ :aChildElement | aChildElement graph isNode ].

	self run: theNodes
]

{ #category : #accessing }
GtGradHierarchicalLayout >> parallelEdgeSpacing [
	"Distance between parallel edges"
	^ parallelEdgeSpacing
]

{ #category : #accessing }
GtGradHierarchicalLayout >> parallelEdgeSpacing: anObject [
	parallelEdgeSpacing := anObject
]

{ #category : #'private-layout' }
GtGradHierarchicalLayout >> placementStage: parent initialX: initialX [
]

{ #category : #accessing }
GtGradHierarchicalLayout >> roots [
	^ roots
]

{ #category : #accessing }
GtGradHierarchicalLayout >> roots: anObject [
	roots := anObject
]

{ #category : #'api - layout' }
GtGradHierarchicalLayout >> run: theGraphNodesList [
	| aHierarchyNodesCollection visitedNodes initialX |
	"this is a list of sets"
	aHierarchyNodesCollection := OrderedCollection new.
	visitedNodes := Set new.
	self roots isNil
		ifTrue: [
			| filledNodesSet |
			self roots: OrderedCollection new.
			filledNodesSet := OrderedCollection new.
			filledNodesSet addAll: theGraphNodesList.
			[filledNodesSet isNotEmpty]
				whileTrue: [
					| rootCandidates |
					rootCandidates := self findRoots: filledNodesSet.
					rootCandidates do: [ :aRootCandidate |
						| theCurrentNodesSet |
						theCurrentNodesSet := Set new.
						aHierarchyNodesCollection add: theCurrentNodesSet.
						self traverse: aRootCandidate directed: false  visitedNodes: visitedNodes  currentComponent:  theCurrentNodesSet hierarchyComponents:  aHierarchyNodesCollection filledNodesSet: filledNodesSet
					].
					self roots addAll: rootCandidates.
				]
			]
		ifFalse: [ 
			self roots do: [ :aRoot |
				| theCurrentNodesSet |
				theCurrentNodesSet := Set new.
				aHierarchyNodesCollection add: theCurrentNodesSet.
				self traverse: aRoot directed: true  visitedNodes: visitedNodes  currentComponent:  theCurrentNodesSet hierarchyComponents:  aHierarchyNodesCollection filledNodesSet: nil
			]
	].
	"Perform layout for each separate hierarchy"
	initialX := 0.
	aHierarchyNodesCollection do: [ :aHierarchySet |
		| model |
		model := GtGradHierarchyModel from: aHierarchySet.
		self cycleStage: model.
		"self crossingStage."
		"self layeringStage."
		"initialX := self placementStage: parent initialX: initialX."
	]

]

{ #category : #'private-layout' }
GtGradHierarchicalLayout >> traverse: aNode directed: isDirectedTraversal visitedNodes: theVisitedNodes currentComponent: theCurrentComponent hierarchyComponents: theHierarchyComponents filledNodesSet: aFilledNodesSet [
	(aNode isNil or: [ theVisitedNodes isNil ])
		ifTrue: [ ^ self	].
	(((theVisitedNodes includes: aNode) not) and: [ aFilledNodesSet isNil or: [
			aFilledNodesSet includes: aNode]])
		ifTrue: [ 
			theCurrentComponent add: aNode.
			theVisitedNodes add: aNode.
			
			(aFilledNodesSet isNotNil and: [ aFilledNodesSet includes: aNode ])
				ifTrue:[
					aFilledNodesSet remove: aNode
				].

			aNode graph nodesAlongOutgoingEdges do: [ :aChildNode |
				self traverse: aChildNode directed: false visitedNodes: theVisitedNodes currentComponent: theCurrentComponent hierarchyComponents: theHierarchyComponents filledNodesSet: aFilledNodesSet.
			].
			isDirectedTraversal
				ifTrue: [ 
					"also process incoming edges"
					aNode graph nodesAlongIncomingEdges do: [ :aChildNode |
						self traverse: aChildNode directed: true visitedNodes: theVisitedNodes currentComponent: theCurrentComponent hierarchyComponents: theHierarchyComponents filledNodesSet: aFilledNodesSet.
					]
				]
		]
		ifFalse: [ 
			(theCurrentComponent includes: aNode)
				ifFalse: [ 
					"this nodes belongs to a different component, so
					 merge it with the current one"
					| matchedComponent |
					matchedComponent := nil.
					
					theHierarchyComponents do: [ :aComponent |
						(aComponent includes: aNode)
							ifTrue: [ 
								matchedComponent := aComponent.
								theCurrentComponent addAll: aComponent.
							]
					].
					matchedComponent isNotNil
						ifTrue: [ 
							theHierarchyComponents remove: matchedComponent	
						]
				]
		].
]
