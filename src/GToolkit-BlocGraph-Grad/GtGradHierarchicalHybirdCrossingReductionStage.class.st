Class {
	#name : #GtGradHierarchicalHybirdCrossingReductionStage,
	#superclass : #GtGradHierarchicalLayoutStage,
	#instVars : [
		'maxIterations',
		'nestedBestCanks',
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
	(1 to: self model ranks count) do: [ :aRankIndex |
		totalCrossings := totalCrossings + self calculateRankCrossings: aRankIndex
	].
	
	^ totalCrossings.
]

{ #category : #'layout - computations' }
GtGradHierarchicalHybirdCrossingReductionStage >> calculateRankCrossings: aRanksIndex [
	| currentRank previousRank totalCrossing connections |
	currentRank := model ranks at: aRanksIndex.
	previousRank := model ranks at: aRanksIndex - 1.

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
GtGradHierarchicalHybirdCrossingReductionStage >> nestedBestCanks [
	^ nestedBestCanks
]

{ #category : #accessing }
GtGradHierarchicalHybirdCrossingReductionStage >> nestedBestCanks: anObject [
	nestedBestCanks := anObject
]
