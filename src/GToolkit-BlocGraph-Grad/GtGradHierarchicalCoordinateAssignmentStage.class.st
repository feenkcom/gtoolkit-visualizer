Class {
	#name : #GtGradHierarchicalCoordinateAssignmentStage,
	#superclass : #GtGradHierarchicalLayoutStage,
	#instVars : [
		'intraRankSpacing',
		'interRanksSpacing',
		'parallelEdgeSpacing',
		'nodesConnectionBuffer',
		'maxIterations',
		'preferredHorizontalEdgesSeparation',
		'prefferedVerticalEdgesOffset',
		'minEdgeJetty',
		'channelBuffer',
		'jettyPositionsDictionary',
		'initalX',
		'limitX',
		'currentXDelta',
		'topYPerRank',
		'bottomYPerRank',
		'widestRankValue',
		'rankWidths',
		'rankYvalues',
		'fineTuning',
		'nextLayerConnectedElementsCache',
		'previousLayerConnectedCache'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #'layout - computations' }
GtGradHierarchicalCoordinateAssignmentStage >> addConnectedNodesToWeightedNodesList: aConnectedNodesCollection weightedNodesList: aWeightedNodesCollection nodesWeightedNodesDictionary: aNodesWeightedNodesDictionary [
	" Helpter method to avoid duplicate code in minNode "
	aConnectedNodesCollection do: [ :aNode |
		(aNodesWeightedNodesDictionary includesKey: aNode)
			ifTrue: [
 			  | weightedConnectedNode |
				weightedConnectedNode := aNodesWeightedNodesDictionary at: aNode.
				weightedConnectedNode visited
					ifFalse: [ 
						weightedConnectedNode visited: true.
						aWeightedNodesCollection add: weightedConnectedNode.	
					]	
				]		
			]
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> bottomYPerRank [
	^ bottomYPerRank
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> bottomYPerRank: anObject [
	bottomYPerRank := anObject
]

{ #category : #'layout - computations' }
GtGradHierarchicalCoordinateAssignmentStage >> calculateWeight: theCurrentNode nodes: aNodesCollection [
	| totalWeight |
	totalWeight := 0.
	"TODO replace those is member of callse"
	aNodesCollection do: [ :aNode |
		((theCurrentNode isMemberOf: GtGradHierarchyNode) and: [ aNode isMemberOf: GtGradHierarchyNode])
			ifTrue: [ totalWeight += totalWeight + 1 ]
			ifFalse: [ 
				((theCurrentNode isMemberOf: GtGradHierarchyEdge) and: [ aNode isMemberOf: GtGradHierarchyEdge])
					ifTrue: [ totalWeight += totalWeight + 8 ]
					ifFalse: [ totalWeight += totalWeight + 2 ]
			]
	].
	^ totalWeight
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> channelBuffer [
	^ channelBuffer
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> channelBuffer: anObject [
	channelBuffer := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> currentXDelta [
	^ currentXDelta
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> currentXDelta: anObject [
	currentXDelta := anObject
]

{ #category : #'layout - computations' }
GtGradHierarchicalCoordinateAssignmentStage >> execute: parent [
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> fineTuning [
	^ fineTuning
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> fineTuning: anObject [
	fineTuning := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> initalX [
	^ initalX
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> initalX: anObject [
	initalX := anObject
]

{ #category : #initialization }
GtGradHierarchicalCoordinateAssignmentStage >> initialize [
	self intraRankSpacing: 30.
	self interRanksSpacing: 30.
	self parallelEdgeSpacing: 4.
	self nodesConnectionBuffer: 0.
	self maxIterations: 8.
	self preferredHorizontalEdgesSeparation: 5.
	self prefferedVerticalEdgesOffset: 2.
	self minEdgeJetty: 12.
	self channelBuffer: 4.
	self jettyPositionsDictionary: IdentityDictionary new.
	self fineTuning: true.

	
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> interRanksSpacing [
	^ interRanksSpacing
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> interRanksSpacing: anObject [
	interRanksSpacing := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> intraRankSpacing [
	^ intraRankSpacing
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> intraRankSpacing: anObject [
	intraRankSpacing := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> jettyPositionsDictionary [
	^ jettyPositionsDictionary
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> jettyPositionsDictionary: anObject [
	jettyPositionsDictionary := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> limitX [
	^ limitX
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> limitX: anObject [
	limitX := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> maxIterations [
	^ maxIterations
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> maxIterations: anObject [
	maxIterations := anObject
]

{ #category : #'layout - computations' }
GtGradHierarchicalCoordinateAssignmentStage >> medianPositioning: theCurrentIteration [
	| downwardSweep |
	downwardSweep := theCurrentIteration even.
	downwardSweep
		ifTrue: [ 
			model maxRank to: 1 by: -1 do: [ :aRankValue |
				self rankMedianPosition: aRankValue - 1 nextValue: aRankValue.
			]
		]
		ifFalse: [ 
			 1 to: model maxRank - 1 do: [ :aRankValue |
				self rankMedianPosition: aRankValue + 1 nextValue: aRankValue.
			]
		]
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> medianXValue: aConnectedElementsCollection layer: aLayerNum [
]

{ #category : #'layout - computations' }
GtGradHierarchicalCoordinateAssignmentStage >> medianXValue: aConnectedElementsCollection rankValue: theRankValue [
	| medianValues |
	aConnectedElementsCollection isEmpty
		ifTrue: [ ^ 0 ].
	
	medianValues := (aConnectedElementsCollection collect: [ :aNode |
		aNode rankPositionsAt: theRankValue.
	]) asSortedCollection.

	aConnectedElementsCollection count odd
		ifTrue: [ 
			^ medianValues at: ((aConnectedElementsCollection count / 2)  + 1).
		]
		ifFalse: [ 
			| medianPoint leftMedian rightMedian |
			medianPoint := aConnectedElementsCollection count / 2.
			leftMedian := medianValues at: medianPoint.
			rightMedian := medianValues at: medianPoint + 1.
			^ (leftMedian + rightMedian) / 2.
		]

	
		
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> minEdgeJetty [
	^ minEdgeJetty
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> minEdgeJetty: anObject [
	minEdgeJetty := anObject
]

{ #category : #'layout - computations' }
GtGradHierarchicalCoordinateAssignmentStage >> minNode [
	| weightedElements nodeWeightedElementDictionary rank maxTries triesCount tolerance currentPosition elementMedian |
	weightedElements := OrderedCollection new.
	nodeWeightedElementDictionary := IdentityDictionary new.
	rank := Array2D new.
	"TODO once again, think about indexes - just increased by one for npw"
	1 to: (model maxRank + 1) do: [ :aRankValue |
		| aRankSet |
		aRankSet := model ranks at: aRankValue.
		rank at: aRankValue put: aRankSet asCollection.
		(aRankSet at: aRankValue) doWithIndex: [ :aNode :aRankIndex |
			| aWeightedElement |
			aWeightedElement := GtGradHierarchicalWeightedElement new
										element: aNode ;
										rankIndex: aRankIndex;
										visited: true.
			weightedElements add: aWeightedElement.
			nodeWeightedElementDictionary at: aNode  put: aWeightedElement.
		]
	].
	maxTries := weightedElements count * 10.
	triesCount := 0.
	tolerance := 1.
	
	[weightedElements isNotEmpty and: [ triesCount <= maxTries ]]
		whileTrue: [ 
			| aWeightedElement aNode rankValue rankIndex nextLayerConnectedElements previousLayerConnectedElements positionChanged |
			aWeightedElement := weightedElements first.
			aNode := aWeightedElement element.
			rankValue := aWeightedElement weight.
			rankIndex := aWeightedElement rankIndex.
			nextLayerConnectedElements := aNode nextLayerConnectedElements: rankValue.
			previousLayerConnectedElements := aNode previousLayerConnectedElements: rankValue.
			currentPosition := aNode rankPositionsAt: rankValue.
			elementMedian := currentPosition.
			(nextLayerConnectedElements count > 0 or: [ previousLayerConnectedElements count > 0 ])
				ifTrue: [
					| medianNextLevel medianPreviousLevel |
					medianNextLevel := self medianXValue: nextLayerConnectedElements layer: rankValue + 1. 
					medianPreviousLevel := self medianXValue: previousLayerConnectedElements layer: rankValue -1.
					elementMedian := ((medianNextLevel * nextLayerConnectedElements count)	+ (medianPreviousLevel * previousLayerConnectedElements count)) / (nextLayerConnectedElements count + previousLayerConnectedElements count ).
			].
			positionChanged := false.
			elementMedian < (currentPosition - tolerance)
				ifTrue: [ 
					rankIndex = 1
						ifTrue: [ 
							aNode rankPositionsAt: rankValue value: elementMedian.
							positionChanged := true.
						]
						ifFalse: [ 
							| leftNode leftLimit |
							leftNode := rank at: rankValue at: rankIndex - 1.
							leftLimit := leftNode rankPositionsAt: rankValue + (leftNode width / 2) +
											self intraRankSpacing + (aNode width / 2).
							leftLimit < elementMedian
								ifTrue: [
									aNode rankPositionsAt: rankValue value: elementMedian.
									positionChanged := true.
								]
								ifFalse: [ 
									leftLimit < (aNode rankPositionsAt: rankValue - tolerance)
										ifTrue: [ 
											aNode rankPositionsAt: rankValue value: leftLimit.
											positionChanged := true.
										]			
								]
						]
				].
			elementMedian > currentPosition + tolerance
				ifTrue: [ 
						rankIndex = (rank at: rankValue) count
							ifTrue: [ 
								aNode rankPositionsAt: rankValue value: elementMedian.
								positionChanged := true.
							]
							ifFalse: [ 
								| rightNode rightLimit |
								rightNode := rank at: rankValue at: rankIndex + 1.
								rightLimit := rightNode rankPositionsAt: rankValue - (rightNode width / 2) -
											self intraRankSpacing - (aNode width / 2).
								rightLimit > elementMedian
									ifTrue: [
										aNode rankPositionsAt: rankValue value: elementMedian.
										positionChanged := true.
									]
									ifFalse: [ 
										rightLimit > (aNode rankPositionsAt: rankValue + tolerance)
											ifTrue: [ 
												aNode rankPositionsAt: rankValue value: rightLimit.
												positionChanged := true.
											]						
									]	
							]
					].
					positionChanged
						ifTrue: [ 
								self addConnectedNodesToWeightedNodesList: nextLayerConnectedElements weightedNodesList: weightedElements nodesWeightedNodesDictionary: nodeWeightedElementDictionary.
								self addConnectedNodesToWeightedNodesList: previousLayerConnectedElements weightedNodesList: weightedElements nodesWeightedNodesDictionary: nodeWeightedElementDictionary.
						].
					weightedElements removeFirst.
					aWeightedElement visited: false.
					triesCount := triesCount + 1
		].

	
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> nextLayerConnectedElementsCache [
	^ nextLayerConnectedElementsCache
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> nextLayerConnectedElementsCache: anObject [
	nextLayerConnectedElementsCache := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> nodesConnectionBuffer [
	^ nodesConnectionBuffer
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> nodesConnectionBuffer: anObject [
	nodesConnectionBuffer := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> parallelEdgeSpacing [
	^ parallelEdgeSpacing
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> parallelEdgeSpacing: anObject [
	parallelEdgeSpacing := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> preferredHorizontalEdgesSeparation [
	^ preferredHorizontalEdgesSeparation
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> preferredHorizontalEdgesSeparation: anObject [
	preferredHorizontalEdgesSeparation := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> prefferedVerticalEdgesOffset [
	^ prefferedVerticalEdgesOffset
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> prefferedVerticalEdgesOffset: anObject [
	prefferedVerticalEdgesOffset := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> previousLayerConnectedCache [
	^ previousLayerConnectedCache
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> previousLayerConnectedCache: anObject [
	previousLayerConnectedCache := anObject
]

{ #category : #'layout - computations' }
GtGradHierarchicalCoordinateAssignmentStage >> rankMedianPosition: aRankValue nextValue: theNextRankValue [
	| weightedElements nodeWeightedElementDictionary rank |
	"TODO of course, check indexes, is asOrderedCollection necessary"
	rank := model ranks at: aRankValue asOrderedCollection.
	weightedElements := OrderedCollection new.
	nodeWeightedElementDictionary := IdentityDictionary new.
	rank
		doWithIndex: [ :aNode :aRankIndex | 
			| aWeightedElement nextLayerConnectedElements |
			aWeightedElement := GtGradHierarchicalWeightedElement new
				element: aNode;
				rankIndex: aRankIndex.
			nodeWeightedElementDictionary at: aNode put: aWeightedElement.
			nextLayerConnectedElements := theNextRankValue < aRankValue
				ifTrue: [ aNode previousLayerConnectedElements: aRankValue ]
				ifFalse: [ aNode nextLayerConnectedElements: aRankValue ].
			aWeightedElement
				weight: (self calculateWeight: aNode nodes: nextLayerConnectedElements) ].
	weightedElements asSortedCollection
		do: [ :aWeightedElement | 
			| nextLevelConnectionsCount nextLayerConnectedElements medianNextLevel aNode leftBuffer leftLimit rightBuffer rightLimit rankCounter |
			nextLevelConnectionsCount := 0.
			medianNextLevel := 0.
			aNode := aWeightedElement element.
			nextLayerConnectedElements := theNextRankValue < aRankValue
				ifTrue: [ aNode previousLayerConnectedElements: aRankValue ]
				ifFalse: [ aNode nextLayerConnectedElements: aRankValue ].
			nextLayerConnectedElements isNotNil
				ifTrue: [ nextLevelConnectionsCount := nextLayerConnectedElements count.
					medianNextLevel := nextLevelConnectionsCount > 0
						ifTrue: [ self
								medianXValue: nextLayerConnectedElements
								rankValue: theNextRankValue ]
						ifFalse: [ aNode rankPositionsAt: aRankValue ] ].
			leftBuffer := 0.
			leftLimit := -100000000.
			rankCounter := aWeightedElement rankIndex.
			[ rankCounter >= 1 ]
				whileTrue: [ (nodeWeightedElementDictionary includesKey: (rank at: rankCounter))
						ifTrue: [ | leftNode |
							leftNode := nodeWeightedElementDictionary
								at: (rank at: rankCounter) element.
							leftNode visited
								ifTrue: [ leftLimit := leftNode
										rankPositionsAt:
											aRankValue + (leftNode width / 2) + intraRankSpacing + leftBuffer
												+ (aNode width / 2) ]
								ifFalse:
									[ leftBuffer := leftBuffer + leftNode width + intraRankSpacing ].
							rankCounter := rankCounter - 1 ] ].
			rightBuffer := 0.
			rightLimit := -100000000.
			rankCounter := aWeightedElement rankIndex + 1.
			[ rankCounter <= weightedElements count ]
				whileTrue: [ (nodeWeightedElementDictionary includesKey: (rank at: rankCounter))
						ifTrue: [ 
							| rightNode |
							rightNode := nodeWeightedElementDictionary
								at: (rank at: rankCounter) element.
							rightNode visited
								ifTrue: [ leftLimit := rightNode
										rankPositionsAt:
											aRankValue - (rightNode width / 2) - intraRankSpacing - leftBuffer
												- (aNode width / 2).
									rankCounter := weightedElements count + 1 ]
								ifFalse: [ leftBuffer := rightBuffer + rightNode width + intraRankSpacing.
									rankCounter := rankCounter + 1 ] 
					]
			].
			(medianNextLevel > leftLimit and: [ medianNextLevel <= rightLimit ])
				ifTrue: [ aNode rankPositionsAt: aRankValue value: medianNextLevel ].
			medianNextLevel < leftLimit
				ifTrue: [  
					aNode rankPositionsAt: aRankValue value: leftLimit.
					self currentXDelta: self currentXDelta + leftLimit - medianNextLevel
					].
			medianNextLevel > rightLimit
				ifTrue: [ 
					aNode rankPositionsAt: aRankValue value: rightLimit.
					self currentXDelta: self currentXDelta +  medianNextLevel - rightLimit
					].
				aNode visited: true.
		]
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> rankWidths [
	^ rankWidths
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> rankWidths: anObject [
	rankWidths := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> rankYvalues [
	^ rankYvalues
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> rankYvalues: anObject [
	rankYvalues := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> topYPerRank [
	^ topYPerRank
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> topYPerRank: anObject [
	topYPerRank := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> widestRankValue [
	^ widestRankValue
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> widestRankValue: anObject [
	widestRankValue := anObject
]
