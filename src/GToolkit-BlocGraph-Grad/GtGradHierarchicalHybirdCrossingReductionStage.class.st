Class {
	#name : #GtGradHierarchicalHybirdCrossingReductionStage,
	#superclass : #GtGradHierarchicalLayoutStage,
	#instVars : [
		'maxIterations',
		'nestedBestRanks',
		'currentBestCrossings',
		'iterationsWithoutImprovement',
		'maxNoImprovementIterations'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #'layout - computations' }
GtGradHierarchicalHybirdCrossingReductionStage >> calculateCrossings [
	| totalCrossings |
	totalCrossings := 0.
	2 to: self model ranks size do: [ :aRankIndex |
		| rankCrossings |
		rankCrossings := self calculateRankCrossings: aRankIndex. 
		totalCrossings := totalCrossings + rankCrossings
	].
	
	^ totalCrossings.
]

{ #category : #'layout - computations' }
GtGradHierarchicalHybirdCrossingReductionStage >> calculateRankCrossings: aRanksIndex [
	| currentRank previousRank totalCrossings connections |
	"ranks is a collection of sets"
	currentRank := model ranks at: aRanksIndex.
	previousRank := model ranks at: (aRanksIndex - 1).
	connections := Array2D rows: currentRank size columns: previousRank size.
	totalCrossings := 0.
	
	currentRank do: [ :anElement |
		| rankPosition previousLayerElements|
		"Adding one because the indexes start at one"
		rankPosition := (anElement rankPositionsAt: aRanksIndex) + 1.
		previousLayerElements := anElement previousLayerConnectedElementsOnLayer: aRanksIndex.
		previousLayerElements do: [ :aConnectedElement |
			| otherRankPosition |
			otherRankPosition := (aConnectedElement rankPositionsAt: (aRanksIndex - 1)) + 1.
			connections at: rankPosition at: otherRankPosition put: SmallInteger maxVal.
		]
	].
	1 to: currentRank size do: [ :index1 |
		1 to: previousRank size do: [ :index2 |
			(connections at: index1 at: index2) = SmallInteger maxVal
				ifTrue: [ 
					index1 + 1 to: currentRank size do: [ :index12 |
						1 to: index2 -1 do: [ :index22 |
							(connections at: index12 at: index22) = SmallInteger maxVal
								ifTrue: [ totalCrossings := totalCrossings + 1 ]
						 ]
						].
					1 to: index1 - 1 do: [ :index12 |
						index2 + 1 to: previousRank size do: [ :index22 |
							(connections at: index12 at: index22) = SmallInteger maxVal
								ifTrue: [ totalCrossings := totalCrossings + 1 ]
						 ]
					]
				]
			]
		].
	^ totalCrossings / 2.
	
	
	

]

{ #category : #accessing }
GtGradHierarchicalHybirdCrossingReductionStage >> currentBestCrossings [
	^ currentBestCrossings
]

{ #category : #accessing }
GtGradHierarchicalHybirdCrossingReductionStage >> currentBestCrossings: anObject [
	currentBestCrossings := anObject
]

{ #category : #'layout - computations' }
GtGradHierarchicalHybirdCrossingReductionStage >> execute [
	| theCurrentIteration |
	self nestedBestRanks: Dictionary new.
	self model ranks doWithIndex: [ :aRank :anIndex |
		self nestedBestRanks at: anIndex put: aRank copy.
	].
	self iterationsWithoutImprovement: 0.
	self currentBestCrossings: self calculateCrossings.

	theCurrentIteration := 1.
	[theCurrentIteration <= self maxIterations and: [
		iterationsWithoutImprovement < self maxNoImprovementIterations
		and: [ currentBestCrossings > 0 ]]]
		 whileTrue: [
			| candidateCrossings |
			self weightedMedian: theCurrentIteration.
			self transpose: theCurrentIteration.
			candidateCrossings := self calculateCrossings.
			candidateCrossings < currentBestCrossings
				ifTrue: [
					currentBestCrossings := candidateCrossings.
					iterationsWithoutImprovement := 0.
					1 to: (self nestedBestRanks size) do: [ :anIndex |
					 	| aRank |
						aRank := self model ranks at: anIndex.
						aRank do: [ :anElement |
							self nestedBestRanks at: anIndex at: 
								((anElement rankPositionsAt: anIndex) + 1) put: anElement.
						]
					].
				]
				ifFalse: [
					iterationsWithoutImprovement := iterationsWithoutImprovement + 1.
					1 to: (self nestedBestRanks size) do: [ :anIndex |
					 	| aRank |
						aRank := self model ranks at: anIndex.
						aRank doWithIndex: [ :anElement :rankIndex |
							anElement rankPositionsAt: anIndex value: (rankIndex - 1).
						]
					]		
				].
				theCurrentIteration := theCurrentIteration + 1.
			].

	"update model ranks"
	self model ranks: self nestedBestRanks
	
	
	


	
]

{ #category : #initialization }
GtGradHierarchicalHybirdCrossingReductionStage >> initialize [
	maxIterations := 25.
	currentBestCrossings := 0.
	iterationsWithoutImprovement := 0.
	maxNoImprovementIterations := 2.
]

{ #category : #accessing }
GtGradHierarchicalHybirdCrossingReductionStage >> iterationsWithoutImprovement [
	^ iterationsWithoutImprovement
]

{ #category : #accessing }
GtGradHierarchicalHybirdCrossingReductionStage >> iterationsWithoutImprovement: anObject [
	iterationsWithoutImprovement := anObject
]

{ #category : #accessing }
GtGradHierarchicalHybirdCrossingReductionStage >> maxIterations [
	^ maxIterations
]

{ #category : #accessing }
GtGradHierarchicalHybirdCrossingReductionStage >> maxIterations: anObject [
	maxIterations := anObject
]

{ #category : #accessing }
GtGradHierarchicalHybirdCrossingReductionStage >> maxNoImprovementIterations [
	^ maxNoImprovementIterations
]

{ #category : #accessing }
GtGradHierarchicalHybirdCrossingReductionStage >> maxNoImprovementIterations: anObject [
	maxNoImprovementIterations := anObject
]

{ #category : #accessing }
GtGradHierarchicalHybirdCrossingReductionStage >> medianRank: aRankLayer downwardSweep: downwardSweep [
	| elementsByMedianValueDictionary reservedPositions sortedMedianValues aCounter medianCounter |
	elementsByMedianValueDictionary := Dictionary new.
	reservedPositions := OrderedCollection new.
	(self nestedBestRanks at: aRankLayer) do: [ :anElement |
		| nextLevelConnectedElements nextRankLayer |
		downwardSweep
			ifTrue: [ 
				nextLevelConnectedElements := anElement nextLayerConnectedElementsOnLayer: aRankLayer.
				nextRankLayer := aRankLayer + 1.
			]
			ifFalse: [
				nextLevelConnectedElements := anElement previousLayerConnectedElementsOnLayer: aRankLayer.
				nextRankLayer := aRankLayer -1
			].
		(nextLevelConnectedElements isNotNil and: [ nextLevelConnectedElements isNotEmpty ])
			ifTrue: [ 
				| medianValue |
				medianValue := self medianValue: nextLevelConnectedElements rankLayer: nextRankLayer.
				(elementsByMedianValueDictionary includesKey: medianValue)
					ifFalse: [ 
						elementsByMedianValueDictionary at: medianValue put: OrderedCollection new.
					].
				(elementsByMedianValueDictionary at: medianValue) add: anElement.
			]
			ifFalse: [ 
				"nodes with no adjacent nodes should remain where they are"
				reservedPositions add: (anElement rankPositionsAt: aRankLayer)
				]
		].
		sortedMedianValues := elementsByMedianValueDictionary keys asSortedCollection.

		medianCounter := 1.
		aCounter := 1.
		[ aCounter <= (nestedBestRanks at: aRankLayer) size ] 
			whileTrue: [ 
				| theCurrentMedian |
				theCurrentMedian := sortedMedianValues at: medianCounter.
				(elementsByMedianValueDictionary at: theCurrentMedian) do: [ :anElement |
					(reservedPositions includes: aCounter)
						ifFalse: [
							anElement rankPositionsAt: aRankLayer value: (aCounter - 1).
						].
					aCounter := aCounter + 1.
				].
			medianCounter := medianCounter + 1.
		]
		
]

{ #category : #accessing }
GtGradHierarchicalHybirdCrossingReductionStage >> medianValue: aConnectedElementsCollection rankLayer: aRankLayer [
	| medianValues medianCollectionCount medianPoint leftMedian rightMedian |
	medianValues := aConnectedElementsCollection collect: [ :anElement |
		anElement rankPositionsAt: aRankLayer
	].
	medianValues := medianValues asSortedCollection.
	medianCollectionCount := medianValues size.
	medianCollectionCount odd
		ifTrue: [ ^medianValues at: (medianCollectionCount // 2) + 1].
	medianCollectionCount = 2
		ifTrue: [ ^(medianValues first + medianValues second) / 2 ].
	self halt.
	medianPoint := medianCollectionCount // 2.
	leftMedian := medianValues at: medianPoint - medianValues first.
	rightMedian := medianValues last - medianValues at: (medianPoint  + 1).
	^ (((medianValues at: medianPoint) * rightMedian) + 
	((medianValues at: (medianPoint  + 1)) * leftMedian)) / (leftMedian + rightMedian)
	
	
	
	
]

{ #category : #accessing }
GtGradHierarchicalHybirdCrossingReductionStage >> nestedBestRanks [
	^ nestedBestRanks
]

{ #category : #accessing }
GtGradHierarchicalHybirdCrossingReductionStage >> nestedBestRanks: anObject [
	nestedBestRanks := anObject
]

{ #category : #'layout - computations' }
GtGradHierarchicalHybirdCrossingReductionStage >> transpose: mainLoopIndex [
	| improved loopIndex maxIndex |
	"TODO need to make sure that everything is ok with indexes and such, seeing that
	here indexes start at 1."
	loopIndex := 0.
	maxIndex := 10.
	improved := true.

	[improved and: [ loopIndex < maxIndex ]]
		whileTrue: [ 
			| nudge |
			loopIndex := loopIndex + 1.
			improved := false.
			nudge := mainLoopIndex even and: [ loopIndex even ].
			model ranks doWithIndex: [ :aRank :aRankIndex |
				| orderedElements leftElementsAboveConnections leftElementsBelowConnections
				rightElementsAboveConnections rightElementsBelowConnections
				leftElement rightElement leftAbovePositions leftBelowPositions
				rightAbovePositions rightBelowPositions |
				orderedElements := Dictionary new.
				rightElementsAboveConnections := nil.
				rightElementsBelowConnections := nil.
				rightAbovePositions := nil.
				rightBelowPositions := nil.
				rightElement := nil.
				aRank do: [ :anElement |
					orderedElements at: (anElement rankPositionsAt: aRankIndex) + 1 put: anElement.
				].
				1 to: (aRank size - 1) do: [ :aLayer |
					| totalCurrentCrossings totalSwitchedCrossings |
					"For each adjacent pair of elements, check if
					swapping them would reduce the total number of edge crossings."	
					aLayer = 1
						ifTrue: [
							leftElement := orderedElements at: aLayer.
							leftElementsAboveConnections := leftElement nextLayerConnectedElementsOnLayer: aRankIndex.
							leftElementsBelowConnections := leftElement previousLayerConnectedElementsOnLayer: aRankIndex.
							leftAbovePositions := OrderedCollection new.
							leftBelowPositions := OrderedCollection new.
							
							leftAbovePositions := leftElementsAboveConnections collect: [ :anElement |
								anElement rankPositionsAt: (aRankIndex + 1).
							].
							leftBelowPositions := leftElementsBelowConnections collect: [ :anElement |
								anElement rankPositionsAt: (aRankIndex - 1).
							]
						]
						ifFalse: [
							leftElementsAboveConnections := rightElementsAboveConnections.
							leftElementsBelowConnections := rightElementsBelowConnections.
							leftAbovePositions := rightAbovePositions.
							leftBelowPositions := rightBelowPositions.
							leftElement := rightElement.
						].
					rightElement := orderedElements at: aLayer + 1.
					rightElementsAboveConnections := rightElement nextLayerConnectedElementsOnLayer: aRankIndex.
					rightElementsBelowConnections := rightElement previousLayerConnectedElementsOnLayer: aRankIndex.
					rightAbovePositions := rightElementsAboveConnections collect: [ :anElement |
						anElement rankPositionsAt: (aRankIndex + 1).
					].
					rightBelowPositions := rightElementsBelowConnections collect: [ :anElement |
						anElement rankPositionsAt: (aRankIndex - 1).
					].
	
					totalCurrentCrossings := 0.
					totalSwitchedCrossings := 0.
					
					leftAbovePositions do: [ :leftPosition |
						rightAbovePositions do: [ :rightPosition |										                                    leftPosition > rightPosition
								ifTrue: [ totalCurrentCrossings := totalCurrentCrossings  + 1 ].
							rightPosition > leftPosition
								ifTrue: [ totalSwitchedCrossings := totalSwitchedCrossings + 1 ].
						]			
					].

					leftBelowPositions do: [ :leftPosition |
						rightBelowPositions do: [ :rightPosition |										                                    leftPosition > rightPosition
								ifTrue: [ totalCurrentCrossings := totalCurrentCrossings  + 1 ].
							rightPosition > leftPosition
								ifTrue: [ totalSwitchedCrossings := totalSwitchedCrossings + 1 ].
						]			
					].

					(totalSwitchedCrossings < totalCurrentCrossings or: 
						[ totalSwitchedCrossings = totalCurrentCrossings and: [ nudge ] ])
						ifTrue: [ 
							| rankPosition |
							rankPosition := leftElement rankPositionsAt: aRankIndex.
							leftElement rankPositionsAt: aRankIndex value: (rightElement rankPositionsAt: aRankIndex).
							rightElement rankPositionsAt: aRankIndex value: rankPosition.
							rightElementsAboveConnections := leftElementsAboveConnections.
							rightElementsBelowConnections := leftElementsBelowConnections.
							rightAbovePositions := leftAbovePositions.
							rightBelowPositions := leftBelowPositions.
							rightElement := leftElement.
							improved := nudge not.
						]
				]
			]
		].
	
	
]

{ #category : #'layout - computations' }
GtGradHierarchicalHybirdCrossingReductionStage >> weightedMedian: mainLoopIteration [
	| downwardSweep |
	downwardSweep := mainLoopIteration odd.
	downwardSweep
		ifTrue: [ 
			model maxRank to: 1 by: -1 do: [ :aRankValue |
				self medianRank: aRankValue downwardSweep: downwardSweep
			 ].
		]
		ifFalse: [ 
			2 to: model maxRank do: [ :aRankValue|
				self medianRank: aRankValue downwardSweep: downwardSweep
			 ].
		]
]
