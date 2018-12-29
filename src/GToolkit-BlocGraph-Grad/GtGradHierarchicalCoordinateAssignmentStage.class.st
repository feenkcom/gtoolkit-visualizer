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
		'initialX',
		'limitX',
		'currentXDelta',
		'topYPerRank',
		'bottomYPerRank',
		'widestRankValue',
		'rankWidths',
		'rankYvalues',
		'fineTuning',
		'nextLayerConnectedElementsCache',
		'previousLayerConnectedCache',
		'widestRank'
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

{ #category : #'layout - computations' }
GtGradHierarchicalCoordinateAssignmentStage >> calculateWidestRank [
	| yValue lastRankMaxElementHeight distanceToNextRank |
	yValue := self interRanksSpacing negated.
	lastRankMaxElementHeight := 0.
	self rankWidths: (Array new: self model maxRank + 1).
	self rankYvalues: (Array new: self model maxRank + 1).
	(self model maxRank + 1) to: 1 by: -1 do: [ :aRankValue |
		| maxElementHeight localX aRankSet |
		maxElementHeight := 0.
		aRankSet := model ranks at: aRankValue.
		localX := self initialX.
		aRankSet do: [ :aNode |
			"TODO remove isMemberOf
			The code below is mostly the same as in rank coordinates
			Create a method"
			(aNode isMemberOf: GtGradHierarchyNode)
			ifTrue: [ 
				self setNodeWidthAndHeight: aNode.
				 maxElementHeight := maxElementHeight max: aNode height.
			]
			ifFalse: [ 
				| numberOfEdges |
				numberOfEdges := 1.
				aNode edges isNotNil
					ifTrue: [ numberOfEdges := aNode edges size ].
				aNode width: (numberOfEdges - 1) * self parallelEdgeSpacing.
			].
			localX := localX + (aNode width / 2).
			aNode xPositionAt: aRankValue value: localX.
			aNode rankPositionsAt: aRankValue value: localX rounded.
			localX := localX + (aNode width / 2) + self intraRankSpacing.
			localX > self widestRankValue
				ifTrue: [
					self widestRankValue: localX.
					self widestRank: aRankValue.	
				].
			self rankWidths at: aRankValue put: localX.
		].
		self rankYvalues at: aRankValue put: yValue.
		distanceToNextRank := (maxElementHeight / 2) + 
									(lastRankMaxElementHeight / 2) +
									self interRanksSpacing.
		lastRankMaxElementHeight := maxElementHeight.
		yValue := yValue + (self distanceToNextRankIncrement: distanceToNextRank).
		aRankSet do:  [ :aNode |
			aNode yPositionAt: aRankValue value: yValue.
		]									
	].
		
		
		
		
	

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
GtGradHierarchicalCoordinateAssignmentStage >> distanceToNextRankIncrement: aValue [
	self subclassResponsibility
]

{ #category : #'layout - computations' }
GtGradHierarchicalCoordinateAssignmentStage >> execute [
	| bestXDelta |
	self currentXDelta: 0.
	self initializeCoordinates.
	bestXDelta := 100000000.
	self fineTuning
		ifTrue: [ 1 to: self maxIterations
				do: [ :anIteration | 
					anIteration > 1
						ifTrue: [ self medianPositioning: anIteration ].
					self minNode.
					self model ranks
						doWithIndex: [ :aRankSet :anIndex | 
							aRankSet
								do: [ :aNode | 
									self currentXDelta < bestXDelta
										ifTrue:
											[ aNode xPositionAt: anIndex value: (aNode rankPositionsAt: anIndex) ]
										ifFalse:
											[ aNode rankPositionsAt: anIndex value: (aNode xPositionAt: anIndex) ].
									bestXDelta := bestXDelta min: self currentXDelta ] ].
					self minPath.
					self currentXDelta: 0 ] ]
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
GtGradHierarchicalCoordinateAssignmentStage >> initialX [
	^ initialX
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> initialX: anObject [
	initialX := anObject
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
	self widestRankValue: 0.
	self fineTuning: true.

	
]

{ #category : #'layout - computations' }
GtGradHierarchicalCoordinateAssignmentStage >> initializeCoordinates [
	self calculateWidestRank.
	"sweep up and down from the widest rank"
	
	self widestRank to: 1 by: -1 do: [ :aRankValue |
		Halt now.
		aRankValue < self model maxRank
			ifTrue: [ self rankCoordinates: aRankValue ]
	].

	self widestRank + 1 to: self model maxRank do: [ :aRankValue |
		aRankValue > 0
			ifTrue: [ self rankCoordinates: aRankValue  ]	
	]
		


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

{ #category : #'layout - computations' }
GtGradHierarchicalCoordinateAssignmentStage >> minPath [
	"This methods straightens edges.
	Skipping calculation of edge segments for now...
	Should be implemented later"
	
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

{ #category : #'layout - computations' }
GtGradHierarchicalCoordinateAssignmentStage >> positionElement: anElement positionX: positionX positionY: positionY [
	self subclassResponsibility

]

{ #category : #'layout - computations' }
GtGradHierarchicalCoordinateAssignmentStage >> positionElements [
	"This method is supposed to position both nodes and edges
	For now, we are only positioning nodes
	Also, this handles resizing parents, but we will skip that
	for now as well"

	self
		topYPerRank: (model ranks collect: [ :aRank | SmallInteger maxVal ]).
	self bottomYPerRank: OrderedCollection new.
	self model hierarchyNodesDictionary
		valuesDo: [ :aNode | self positionNode: aNode ]
]

{ #category : #'layout - computations' }
GtGradHierarchicalCoordinateAssignmentStage >> positionNode: aNode [
	| anElement positionX positionY |
	anElement := aNode element.
	positionX := aNode xPositions first - (aNode width / 2).
	positionY := aNode yPositions first - (aNode height / 2).
	self topYPerRank at: aNode minRank put: ((self topYPerRank at: aNode minRank) min: positionY).
	self bottomYPerRank at: aNode minRank put: ((self topYPerRank at: aNode minRank) max: (positionY + aNode height)).
	self positionElement: anElement positionX: positionX positionY: positionY.
	"limitX is needed while positioning edges, so this is not necesarry for now..."
	self limitX: (self limitX max: positionX + aNode width)
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
GtGradHierarchicalCoordinateAssignmentStage >> rankCoordinates: aRankValue [
	| aRankSet maxY localX |
	"TODO replace isMemberOf"
	aRankSet := model ranks at: aRankValue.
	maxY := 0.
	localX := self initialX + ((self widestRankValue - self rankWidths at: aRankValue) / 2).
	aRankSet do: [ :aNode |
		(aNode isMemberOf: GtGradHierarchyNode)
			ifTrue: [ 
				self setNodeWidthAndHeight: aNode.
				 maxY := maxY max: aNode height.
			]
			ifFalse: [ 
				| numberOfEdges |
				numberOfEdges := 1.
				aNode edges isNotNil
					ifTrue: [ numberOfEdges := aNode edges count ].
				aNode width: (numberOfEdges - 1) * self parallelEdgeSpacing.
			].
			localX := localX + aNode width / 2.
			aNode xPositionAt: aRankValue value: localX.
			aNode rankPositionsAt: aRankValue value: localX.
			localX := localX + aNode width / 2 + self intraRankSpacing
		]
	
	
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

{ #category : #'layout - computations' }
GtGradHierarchicalCoordinateAssignmentStage >> repositionOfElementValid: aHierarchyElement rank: aRankValue position: aPositionValue [
	| aRankCollection aRankIndex currentRankPosition |
	aRankCollection := (model ranks at: aRankValue) asOrderedCollection.
	aRankIndex := aRankCollection indexOf: aHierarchyElement.
	aRankIndex = 0
		ifTrue: [ ^ false ].
	currentRankPosition := aHierarchyElement rankPositionsAt: aRankValue.
	aPositionValue < currentRankPosition
		ifTrue: [
			| leftElement leftLimit |
			aRankIndex = 1
				ifTrue: [ 
					"left-most node can be moved anywhere"	
					^ true.
				].
			leftElement := aRankCollection at: [ aRankIndex  - 1 ].
			leftLimit := leftElement rankPositionsAt: aRankValue +
							 (leftElement width / 2) +
							 intraRankSpacing + (aHierarchyElement width / 2).
			^ leftLimit <= aPositionValue	
		].
		aPositionValue > currentRankPosition
			ifTrue: [
				| rightElement rightLimit |
				aRankIndex = aRankCollection count
					ifTrue: [ 
						"left-most node can be moved anywhere"	
						^ true.
					].
				rightElement := aRankCollection at: [ aRankIndex  + 1 ].
				rightLimit := rightElement rankPositionsAt: aRankValue -
							 (rightElement width / 2) -
							 intraRankSpacing - (aHierarchyElement width / 2).
				^ rightLimit >= aPositionValue	
			].
	^ true
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> setNodeWidthAndHeight: aNode [
	self subclassResponsibility
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
GtGradHierarchicalCoordinateAssignmentStage >> widestRank [
	^ widestRank
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> widestRank: anObject [
	widestRank := anObject
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> widestRankValue [
	^ widestRankValue
]

{ #category : #accessing }
GtGradHierarchicalCoordinateAssignmentStage >> widestRankValue: anObject [
	widestRankValue := anObject
]
