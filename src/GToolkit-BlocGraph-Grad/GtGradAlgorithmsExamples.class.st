Class {
	#name : #GtGradAlgorithmsExamples,
	#superclass : #GtGradExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #example }
GtGradAlgorithmsExamples >> simpleDijkstrasAlgorithmExample [
	<gtExample>
	<return: #IdentityDictionary>
	| theNodes pairsOfNodes algorithm paths |
	theNodes := self nodes: (1 to: 7).
	pairsOfNodes := {1 -> 2.
			1 -> 3.
			2 -> 4.
			3 -> 5.
			4 -> 5.
			3 -> 6.
			4 -> 6.
			6 -> 5.
			6 -> 7}.

	self connectPairsOfNodes: theNodes pairs: pairsOfNodes.

	algorithm := DijkstrasShortestPath new.
	paths := algorithm
			calculateShortestPathFromSourceUnweighted: theNodes
			source: (theNodes at: 1).

	self assert: (paths at: (theNodes at: 2)) size equals: 1.
	self assert: (paths at: (theNodes at: 3)) size equals: 1.
	self assert: (paths at: (theNodes at: 4)) size equals: 2.
	self assert: (paths at: (theNodes at: 5)) size equals: 2.
	self assert: (paths at: (theNodes at: 6)) size equals: 2.
	self assert: (paths at: (theNodes at: 7)) size equals: 3.

	^ paths
]

{ #category : #example }
GtGradAlgorithmsExamples >> simpleDijkstrasAlgorithmExampleToTarget [
	<gtExample>
	<return: #OrderedCollection>
	| theNodes pairsOfNodes algorithm path |
	theNodes := self nodes: (1 to: 7).

	pairsOfNodes := {1 -> 2.
			1 -> 3.
			2 -> 4.
			3 -> 5.
			3 -> 6.
			4 -> 5.
			4 -> 6.
			6 -> 5.
			6 -> 7}.

	self connectPairsOfNodes: theNodes pairs: pairsOfNodes.

	algorithm := DijkstrasShortestPath new.

	path := algorithm
			calculateShortestPathFromSourceToTargetUnweighted: theNodes
			source: (theNodes at: 1)
			target: (theNodes at: 7).

	self assert: path size equals: 3.

	^ path
]
