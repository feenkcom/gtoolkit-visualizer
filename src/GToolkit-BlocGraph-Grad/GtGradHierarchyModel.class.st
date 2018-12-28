Class {
	#name : #GtGradHierarchyModel,
	#superclass : #Object,
	#instVars : [
		'roots',
		'ranks',
		'parent',
		'maxRank',
		'hierarchyNodesDictionary',
		'hierarchyEdgesDictionary',
		'dfsCount'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #'instance creation' }
GtGradHierarchyModel class >> directedToUndirectedRatio: aSourceElement target: aTargetElement [
	| directedCount undirectedCount |
	directedCount := 0.
	undirectedCount := 0.
	aSourceElement graph nodesAlongOutgoingEdges do: [ :aConnectedElement |
		aConnectedElement = aTargetElement
			ifTrue: [ 
				directedCount := directedCount + 1.
			]
	].
	undirectedCount := directedCount.
	aSourceElement graph nodesAlongIncomingEdges do: [ :aConnectedElement |
		aConnectedElement = aTargetElement
			ifTrue: [ 
				undirectedCount := undirectedCount + 1.
			]
	].
	^ directedCount / undirectedCount


]

{ #category : #'instance creation' }
GtGradHierarchyModel class >> from: aCollectionOfElements [
	"Create an internal hierarchy model"
	| nodesDictionary connectedElementsDictionary |
	nodesDictionary := IdentityDictionary new.
	"For each key value pair in this dictionary a hierachy edge is constructed"
	connectedElementsDictionary := IdentityDictionary new.
	aCollectionOfElements do: [ :anElement |
		| connectedElements aHierarchyNode|
		connectedElementsDictionary at: anElement ifAbsentPut: OrderedCollection new.
		connectedElements := connectedElementsDictionary at: anElement.
		(nodesDictionary includesKey: anElement)
			ifFalse: [
				nodesDictionary at: anElement put: (GtGradHierarchyNode on: anElement).
			].
		aHierarchyNode := nodesDictionary at: anElement.
		anElement graph nodesAlongOutgoingEdges do: [ :anOutgoingElement |
			anOutgoingElement ~= anElement
				ifTrue: [
					| otherElementConnectedElements |
					connectedElementsDictionary at: anOutgoingElement ifAbsentPut: OrderedCollection new.
					otherElementConnectedElements := connectedElementsDictionary at: anOutgoingElement.
					((connectedElements includes: anOutgoingElement) or: [ otherElementConnectedElements includes: anElement ])
						ifFalse: [ 
							"All edges between this source and its targets need to be processed
							If there are back edges which create loops, they are callected into one
							hierarchical edge.
							It is assumed that source -> target is the natural direction if at least half
							of the edges are going in that direction."
							 (self directedToUndirectedRatio: anElement target: anOutgoingElement) >= 0.5
								ifTrue: [
									| hierarchyEdge targetHierarchyNode|
									(nodesDictionary includesKey: anOutgoingElement)
										ifFalse: [
											nodesDictionary at: anOutgoingElement put: (GtGradHierarchyNode on: anOutgoingElement).
										].
									targetHierarchyNode := nodesDictionary at: anOutgoingElement.
									hierarchyEdge := GtGradHierarchyEdge on: aHierarchyNode target: targetHierarchyNode.
									connectedElements add: anOutgoingElement.
									aHierarchyNode addOutgoingEdge: hierarchyEdge.
									targetHierarchyNode addIncomingEdge: hierarchyEdge.
								]
						]
				]
		]
	].
	^ self new hierarchyNodesDictionary: nodesDictionary.

			
	
]

{ #category : #'layout - computations' }
GtGradHierarchyModel >> calculateInitialRank [
	| startNodes startNodesCopy |
	
	startNodes := self rootNodes.
	startNodesCopy := startNodes copy.
		
	[ startNodes isNotEmpty ]
		whileTrue: [ 
			| layerValue loopCounter aNode layerDetermeningEdges edgesToBeMarked allEdgesVisited minimumLayer |
			aNode := startNodes first.
			layerDetermeningEdges := aNode incomingEdges asOrderedCollection.
			edgesToBeMarked := aNode outgoingEdges.
			allEdgesVisited := true.
			minimumLayer :=  100000000.
			loopCounter := 1.
			"TODO why this value?? - can this be a random value?"
			layerValue := 5270620.
			[allEdgesVisited and: [ loopCounter <= layerDetermeningEdges size ]]
				whileTrue: [ 
					| hierarchyEdge	|
					hierarchyEdge := layerDetermeningEdges at: loopCounter.
					hierarchyEdge layer = layerValue
						ifTrue: [
							| otherNode |
							otherNode := hierarchyEdge source.
							minimumLayer := minimumLayer min: (otherNode layer - 1).
						]
						ifFalse: [ 
							allEdgesVisited := false	
						].
					loopCounter := loopCounter + 1
				 ].
			allEdgesVisited
				ifTrue: [ 
					aNode layer: minimumLayer.
					self maxRank: (self maxRank min: minimumLayer).
					edgesToBeMarked isNotNil
						ifTrue: [ 
							edgesToBeMarked do: [ :anEdgeToBeMarked |
								| otherNode |
								anEdgeToBeMarked layer: layerValue.
								otherNode := anEdgeToBeMarked target.
								otherNode layer = -1
									ifTrue: [ 
										startNodes add: otherNode.
										"Mark this node as neither assigned nor assigned.
										It won't be taken into consideration in any calculation"
										otherNode layer: -2.
									].	
							]
						].
					startNodes removeFirst
				]
				ifFalse: [ 
					| removedNode |
					removedNode := startNodes removeFirst.
					startNodes add: aNode.
					(removedNode = aNode and: [ startNodes size = 1])
						ifTrue: [ 
							"Error condition - break out of the loop"
							startNodes removeAll.
						]
				]
		].
	"Normalize the ranks"
	hierarchyNodesDictionary valuesDo: [ :aNode |
		aNode layer: (aNode layer - self maxRank).
	].

	startNodesCopy do: [ :aNode |
		 | currentMaxLayer |
		currentMaxLayer := 0.
		aNode outgoingEdges do: [ :anEdge |
			| otherNode |
			otherNode := anEdge target.
			aNode layer: (currentMaxLayer max: (otherNode layer + 1)).
			currentMaxLayer := aNode layer.
		].
	].

	self maxRank: 100000000 - self maxRank
	
]

{ #category : #'layout - computations' }
GtGradHierarchyModel >> dfs: aRootNode parent: theParentNode connectingEdge: theConnectingEdge visitor: visitor visitedNodes: aVisitedNodesCollection layer: theLayer [
	aRootNode isNil
		ifTrue: [ ^ self].
	(aVisitedNodesCollection includes: aRootNode)
		ifFalse: [ 
			visitor visit: aRootNode
					  parent: theParentNode
					  connectingEdge: theConnectingEdge
					  layer: theLayer
					  visited: false.
			aVisitedNodesCollection add: aRootNode.
			aRootNode outgoingEdges do: [ :anOutgoingEdge|
				self dfs: anOutgoingEdge target
					  parent: aRootNode
					  connectingEdge: anOutgoingEdge
					  visitor: visitor
					  visitedNodes: aVisitedNodesCollection
					  layer: theLayer + 1.
			]
		]
		ifTrue: [ 
			visitor visit: aRootNode
			 		  parent: theParentNode
					  connectingEdge: theConnectingEdge
					  layer: theLayer
					  visited: true.
		].
]

{ #category : #'layout - computations' }
GtGradHierarchyModel >> dfs: aRootNode parent: theParentNode connectingEdge: theConnectingEdge visitor: visitor visitedNodes: aVisitedNodesCollection parentHashCode: theParentHashCode childHashCode: theChildHashCode layer: theLayer [
	aRootNode isNil
		ifTrue: [ ^ self].
	theParentNode isNotNil
		ifTrue: [ 
			(aRootNode hashCode isNil or: [ aRootNode hashCode first ~= theParentNode hashCode first ])
				ifTrue: [ 
					aRootNode hashCode: theParentNode hashCode copy.
					aRootNode hashCode add: theChildHashCode.
				]
			].
		
		(aVisitedNodesCollection includes: aRootNode)
			ifFalse:[
				visitor visit: aRootNode
						  parent: theParentNode
     					  connectingEdge: theConnectingEdge
     					  layer: theLayer
						  visited: false.
				aVisitedNodesCollection add: aRootNode.
				aRootNode outgoingEdges doWithIndex: [ :anEdge :theIndex |
						self dfs: anEdge target 
								 parent: aRootNode
								 connectingEdge: anEdge
								 visitor: visitor
								 visitedNodes: aVisitedNodesCollection
								 parentHashCode: aRootNode hashCode 
								 childHashCode: theIndex
								 layer: theLayer + 1
					]		
			]
		ifTrue: [
			visitor visit: aRootNode
			 		  parent: theParentNode
					  connectingEdge: theConnectingEdge
					  layer: theLayer
					  visited: true
			]

]

{ #category : #accessing }
GtGradHierarchyModel >> dfsCount [
	^ dfsCount
]

{ #category : #accessing }
GtGradHierarchyModel >> dfsCount: anObject [
	dfsCount := anObject
]

{ #category : #'layout - computations' }
GtGradHierarchyModel >> fixRanks [
	| aRootNodesCollection visitor |
	self ranks: ((1 to: maxRank + 1) collect: [ :aNumber|
		OrderedCollection	new.
	]).
	
	"Perform DFS to calculate initial ordering for each rank"
	aRootNodesCollection := self rootNodes.
	visitor := GtGradFixRankHierarchyVisitor new rankCollection: self ranks.
	self visit: visitor dfsRoots: aRootNodesCollection trackAncestors: false visitedNodes: Set new.
]

{ #category : #accessing }
GtGradHierarchyModel >> hierarchyEdgesDictionary [
	^ hierarchyEdgesDictionary
]

{ #category : #accessing }
GtGradHierarchyModel >> hierarchyEdgesDictionary: anObject [
	hierarchyEdgesDictionary := anObject
]

{ #category : #accessing }
GtGradHierarchyModel >> hierarchyNodesDictionary [
	^ hierarchyNodesDictionary
]

{ #category : #accessing }
GtGradHierarchyModel >> hierarchyNodesDictionary: anObject [
	hierarchyNodesDictionary := anObject
]

{ #category : #initialization }
GtGradHierarchyModel >> initialize [
	super initialize.
	self maxRank: SmallInteger maxVal.
	self hierarchyNodesDictionary: IdentityDictionary new.
	self hierarchyEdgesDictionary: IdentityDictionary new.
	self dfsCount: 1.
]

{ #category : #accessing }
GtGradHierarchyModel >> maxRank [
	^ maxRank
]

{ #category : #accessing }
GtGradHierarchyModel >> maxRank: anObject [
	maxRank := anObject
]

{ #category : #accessing }
GtGradHierarchyModel >> parent [
	^ parent
]

{ #category : #accessing }
GtGradHierarchyModel >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
GtGradHierarchyModel >> ranks [
	^ ranks
]

{ #category : #accessing }
GtGradHierarchyModel >> ranks: anObject [
	ranks := anObject
]

{ #category : #accessing }
GtGradHierarchyModel >> rootNodes [
	| aRootElementsCollection |
	aRootElementsCollection := OrderedCollection new.
	self roots isNotNil
		ifTrue: [ 
			self roots do: [ :aRoot |
				(self hierarchyNodesDictionary includesKey: aRoot)
					ifTrue: [ 
						aRootElementsCollection add: (self hierarchyNodesDictionary at: aRoot)
					]		
			].	
		].
	^ aRootElementsCollection
]

{ #category : #accessing }
GtGradHierarchyModel >> roots [
	^ roots
]

{ #category : #accessing }
GtGradHierarchyModel >> roots: anObject [
	roots := anObject
]

{ #category : #'layout - computations' }
GtGradHierarchyModel >> visit: visitor dfsRoots: aDfsRootsCollection trackAncestors: shouldTrackAncestors visitedNodes: aVisitedNodesCollection [
	aDfsRootsCollection isNil
		ifTrue: [ ^ self	].
	aDfsRootsCollection doWithIndex: [ :aDfsRoot :anIndex |
		"TODO: if track ancestors - figure out what's up with that"
		shouldTrackAncestors
			ifTrue: [
				aDfsRoot hashCode: OrderedCollection new.
				aDfsRoot hashCode add: self dfsCount.
				aDfsRoot hashCode add: anIndex.
				self dfs: aDfsRoot parent: nil connectingEdge: nil visitor: visitor visitedNodes:
				aVisitedNodesCollection parentHashCode: aDfsRoot hashCode childHashCode: anIndex layer:1.
			]
			ifFalse: [
				self dfs: aDfsRoot parent: nil connectingEdge: nil visitor: visitor  visitedNodes: aVisitedNodesCollection layer: 1.
			].
		].
	self dfsCount: self dfsCount + 1
]
