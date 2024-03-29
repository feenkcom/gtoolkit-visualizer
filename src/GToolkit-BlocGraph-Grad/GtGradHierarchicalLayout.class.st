Class {
	#name : #GtGradHierarchicalLayout,
	#superclass : #GtGradLayout,
	#instVars : [
		'intraRankSpacing',
		'interRanksSpacing',
		'interHierarchySpacing',
		'parallelEdgeSpacing',
		'roots',
		'positions',
		'placementStage',
		'alignment'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #constraints }
GtGradHierarchicalLayout class >> constraints [
	^ GtGradHierarchicalConstraints new
]

{ #category : #accessing }
GtGradHierarchicalLayout >> alignment [
	^ alignment
]

{ #category : #accessing }
GtGradHierarchicalLayout >> alignment: anAlignment [
	alignment := anAlignment
]

{ #category : #'private-layout' }
GtGradHierarchicalLayout >> coordinateAssignmentClass [
	self subclassResponsibility
]

{ #category : #'private-layout' }
GtGradHierarchicalLayout >> crossingStage: model [
	(GtGradHierarchicalHybridCrossingReductionStage new model: model) execute
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
		incomingEdgesNum := theNode nodesAlongIncomingEdges size.
		outgoingEdgesNum := theNode nodesAlongOutgoingEdges size.
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
	self intraRankSpacing: 30.
	self interRanksSpacing: 50.
	self interHierarchySpacing: 60.
	self parallelEdgeSpacing: 10.
	self positions: IdentityDictionary new.
	self alignment: GtGradHierarchicalLayoutCenterAlignment new.

	
	
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
GtGradHierarchicalLayout >> interRanksSpacing [
	^ interRanksSpacing
]

{ #category : #accessing }
GtGradHierarchicalLayout >> interRanksSpacing: anObject [
	interRanksSpacing := anObject
]

{ #category : #accessing }
GtGradHierarchicalLayout >> intraRankSpacing [
	^ intraRankSpacing
]

{ #category : #accessing }
GtGradHierarchicalLayout >> intraRankSpacing: anObject [
	intraRankSpacing := anObject
]

{ #category : #'private-layout' }
GtGradHierarchicalLayout >> isDescentantOf: childNode parentNode: parentNode [
	^ (parentNode nodesAlongOutgoingEdges includes: childNode) or: [	
	  parentNode nodesAlongOutgoingEdges
		anySatisfy: [ :aChildNode | self isDescentantOf: childNode parentNode: aChildNode ]]
]

{ #category : #'private-layout' }
GtGradHierarchicalLayout >> layeringStage: model [
	model calculateInitialRank.
	model fixRanks
]

{ #category : #measure }
GtGradHierarchicalLayout >> measureChildrenPositions: aParentLayoutNode [
	| aParentGraphNode |

	aParentGraphNode := aParentLayoutNode withGraphNodes withGraphEdges.
	
	"we should recompute nodes each time, otherwise the cache is not invalidated"
	roots := nil.
	self run: aParentGraphNode children.
	roots := nil.

	aParentGraphNode children normalizePositions
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

{ #category : #accessing }
GtGradHierarchicalLayout >> placementStage [
	^ placementStage
]

{ #category : #accessing }
GtGradHierarchicalLayout >> placementStage: anObject [
	placementStage := anObject
]

{ #category : #'private-layout' }
GtGradHierarchicalLayout >> placementStage: model initialX: initialX [
	| coordinateAssignment |
	coordinateAssignment := self coordinateAssignmentClass new
			intraRankSpacing: intraRankSpacing;
			interRanksSpacing: interRanksSpacing;
			parallelEdgeSpacing: parallelEdgeSpacing;
			initialX: initialX;
			model: model;
			alignment: alignment.
	coordinateAssignment execute.
	^ coordinateAssignment limitX + interHierarchySpacing
]

{ #category : #accessing }
GtGradHierarchicalLayout >> positions [
	^ positions
]

{ #category : #accessing }
GtGradHierarchicalLayout >> positions: anObject [
	positions := anObject
]

{ #category : #'private-layout' }
GtGradHierarchicalLayout >> removeCycles: model [
	| aVisitedNodesSet aVisitedNodesSetCopy aRootNodesCollection visitor newRootsCandidates |
	aVisitedNodesSet := Set new.
	aRootNodesCollection := model rootNodes.
	visitor := GtGradHierarchyCycleRemovalVisitor new
			visitedNodes: aVisitedNodesSet.
	model
		visit: visitor
		dfsRoots: aRootNodesCollection
		trackAncestors: true
		visitedNodes: aVisitedNodesSet.
	newRootsCandidates := Set new.
	aVisitedNodesSet size < model hierarchyNodesDictionary size
		ifTrue: [ newRootsCandidates := model hierarchyNodesDictionary values
					copyWithoutAll: aVisitedNodesSet ].

	aVisitedNodesSetCopy := aVisitedNodesSet copy.
	aRootNodesCollection removeAll.
	newRootsCandidates isNotEmpty
		ifTrue: [ aRootNodesCollection add: newRootsCandidates first ].
	model
		visit: visitor
		dfsRoots: aRootNodesCollection
		trackAncestors: true
		visitedNodes: aVisitedNodesSetCopy.
	newRootsCandidates
		do: [ :aRootCandidate | 
			| anElement |
			anElement := aRootCandidate element.
			anElement nodesAlongIncomingEdges isEmpty
				ifTrue: [ model roots add: anElement ] ]
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
		ifTrue: [ | filledNodesSet |
			self roots: OrderedCollection new.
			filledNodesSet := OrderedCollection new.
			filledNodesSet addAll: theGraphNodesList.
			[ filledNodesSet isNotEmpty ]
				whileTrue: [ | rootCandidates |
					rootCandidates := self findRoots: filledNodesSet.
					rootCandidates
						do: [ :aRootCandidate | 
							| theCurrentNodesSet |
							theCurrentNodesSet := Set new.
							aHierarchyNodesCollection add: theCurrentNodesSet.
							self
								traverse: aRootCandidate
								directed: false
								visitedNodes: visitedNodes
								currentComponent: theCurrentNodesSet
								hierarchyComponents: aHierarchyNodesCollection
								filledNodesSet: filledNodesSet ].
					self roots addAll: rootCandidates ] ]
		ifFalse: [ self roots
				do: [ :aRoot | 
					| theCurrentNodesSet |
					theCurrentNodesSet := Set new.
					aHierarchyNodesCollection add: theCurrentNodesSet.
					self
						traverse: aRoot
						directed: true
						visitedNodes: visitedNodes
						currentComponent: theCurrentNodesSet
						hierarchyComponents: aHierarchyNodesCollection
						filledNodesSet: nil ] ].	
						
	"Perform layout for each separate hierarchy"
	initialX := 0.
	aHierarchyNodesCollection
		do: [ :aHierarchySet | 
			| model |
			GtGradHierarchicalLayoutCurrentComponentSignal new
				theCurrentComponent: aHierarchySet;
				emit.
			model := GtGradHierarchyModel from: aHierarchySet.
			model roots: self roots.
			self removeCycles: model.
			self layeringStage: model.
			self crossingStage: model.
			initialX := self placementStage: model initialX: initialX ]
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

			aNode nodesAlongOutgoingEdges do: [ :aChildNode |
				self traverse: aChildNode directed: false visitedNodes: theVisitedNodes currentComponent: theCurrentComponent hierarchyComponents: theHierarchyComponents filledNodesSet: aFilledNodesSet.
			].
			isDirectedTraversal
				ifTrue: [ 
					"also process incoming edges"
					aNode nodesAlongIncomingEdges do: [ :aChildNode |
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
