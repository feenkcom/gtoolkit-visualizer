Class {
	#name : #GtGradHierarchicalHybirdCrossingReductionStage,
	#superclass : #GtGradHierarchicalLayoutStage,
	#instVars : [
		'maxIterations',
		'nestedBestCanks',
		'currentBestCrossings',
		'iterationsWithoutImprovement',
		'maxNoImprovementIterations',
		'nestedBestRanks'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #'layout - computations' }
GtGradHierarchicalHybirdCrossingReductionStage >> calculateCrossings [
	| totalCrossings |
	totalCrossings := 0.
	1 to: self model ranks count do: [ :aRankIndex |
		totalCrossings := totalCrossings + self calculateRankCrossings: aRankIndex
	].
	
	^ totalCrossings.
]

{ #category : #'layout - computations' }
GtGradHierarchicalHybirdCrossingReductionStage >> calculateRankCrossings: aRanksIndex [
	| currentRank previousRank totalCrossings connections |
	"ranks is a collection of sets"
	currentRank := model ranks at: aRanksIndex.
	previousRank := model ranks at: (aRanksIndex - 1).
	connections := Array2D new.
	totalCrossings := 0.
	
	currentRank do: [ :anElement |
		| rankPosition |
		rankPosition := anElement rankPositionsAt: aRanksIndex.
		anElement previousLayerConnectedElements do: [ :aConnectedElement |
			| otherRankPosition |
			otherRankPosition := anElement rankPositionsAt: (aRanksIndex -1).
			connections at: rankPosition at: otherRankPosition put: SmallInteger maxVal.
		].
	].
		
	1 to: currentRank count do: [ :index1 |
		1 to: previousRank count do: [ :index2 |
			(connections at: index1 at: index2) = SmallInteger maxVal
				ifTrue: [ 
					index1 + 1 to: currentRank count do: [ :index12 |
						1 to: index2 do: [ :index22 |
							(connections at: index12 at: index22) = SmallInteger maxVal
								ifTrue: [ totalCrossings := totalCrossings + 1 ]
						 ]
					].
					1 to: index1 count do: [ :index12 |
						index2 + 1 to: previousRank count do: [ :index22 |
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
GtGradHierarchicalHybirdCrossingReductionStage >> medianRank: aRankValue downwardSweep: downwardSweep [
]

{ #category : #accessing }
GtGradHierarchicalHybirdCrossingReductionStage >> nestedBestCanks [
	^ nestedBestCanks
]

{ #category : #accessing }
GtGradHierarchicalHybirdCrossingReductionStage >> nestedBestCanks: anObject [
	nestedBestCanks := anObject
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
			nudge := mainLoopIndex odd and: [ loopIndex odd ].
			model ranks do: [ :aRank |
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
				aRank doWithIndex: [ :anElement :anIndex |
					orderedElements at: (anElement rankPositionsAt: anIndex) put: anElement.
				].
				1 to: aRank count - 1 do: [ :aLayer |
					| totalCurrentCrossings totalSwitchedCrossings |
					"For each adjacent pair of elements, check if
					swapping them would reduce the total number of edge crossings."	
					aLayer = 1
						ifTrue: [ 
							leftElement := orderedElements at: aLayer.
							leftElementsAboveConnections := leftElement nextLayerConnectedElementsOnLayer: aLayer.
							leftElementsBelowConnections := leftElement previousLayerConnectedElementsOnLayer: aLayer.
							leftAbovePositions := OrderedCollection new.
							leftBelowPositions := OrderedCollection new.
							
							leftAbovePositions := leftElementsAboveConnections collect: [ :anElement |
								anElement rankPositionsAt: aRank + 1.
							].
							leftBelowPositions := leftElementsBelowConnections collect: [ :anElement |
								anElement rankPositionsAt: aRank - 1.
							].
						]
						ifFalse: [
							leftElementsAboveConnections := rightElementsAboveConnections.
							leftElementsBelowConnections := rightElementsBelowConnections.
							leftAbovePositions := rightAbovePositions.
							leftBelowPositions := rightBelowPositions.
							leftElement := rightElement.
						].
					rightElement := orderedElements at: aLayer + 1.
					rightElementsAboveConnections := rightElement nextLayerConnectedElementsOnLayer: aRank.
					rightElementsBelowConnections := rightElement previousLayerConnectedElementsOnLayer: aRank.
					rightAbovePositions := rightElementsAboveConnections collect: [ :anElement |
						anElement rankPositionsAt: aRank + 1.
					].
					rightBelowPositions := rightElementsBelowConnections collect: [ :anElement |
						anElement rankPositionsAt: aRank - 1.
					].
				
					totalCurrentCrossings := 0.
					totalSwitchedCrossings := 0.
					
					leftAbovePositions with: rightAbovePositions do: [ :leftPosition :rightPosition |
						leftPosition > rightPosition
							ifTrue: [ totalCurrentCrossings := totalCurrentCrossings  + 1 ].
						rightPosition > leftPosition
							ifTrue: [ totalSwitchedCrossings := totalSwitchedCrossings + 1 ].
					].
					leftBelowPositions with: rightBelowPositions do: [ :leftPosition :rightPosition |
						leftPosition > rightPosition
							ifTrue: [ totalCurrentCrossings := totalCurrentCrossings  + 1 ].
						rightPosition > leftPosition
							ifTrue: [ totalSwitchedCrossings := totalSwitchedCrossings + 1 ].
					].
					(totalSwitchedCrossings < totalCurrentCrossings or: 
						[ totalSwitchedCrossings = totalCurrentCrossings and: [ nudge ] ])
						ifTrue: [ 
							| rankPosition |
							rankPosition := leftElement rankPositionsAt: aRank.
							leftElement rankPositionsAt: aRank value: (rightElement rankPositionsAt: aRank).
							rightElement rankPositionsAt: aRank value: rankPosition.
							rightElementsAboveConnections := leftElementsAboveConnections.
							rightElementsBelowConnections := leftElementsBelowConnections.
							rightAbovePositions := leftAbovePositions.
							rightBelowPositions := leftBelowPositions.
							rightElement := leftElement.
							improved := nudge negated.
						]
				]
			]
		].
	
	
]

{ #category : #'layout - computations' }
GtGradHierarchicalHybirdCrossingReductionStage >> weightedMedian: mainLoopIteration [
	| downwardSweep |
	downwardSweep := mainLoopIteration even.
	downwardSweep
		ifTrue: [ 
			model maxRank to: 1 by: -1 do: [ :aRankValue |
				self medianRank: aRankValue downwardSweep: downwardSweep
			 ].
		]
		ifFalse: [ 
			1 to: model maxRank do: [ :aRankValue|
				self medianRank: aRankValue downwardSweep: downwardSweep
			 ].
		]
]
