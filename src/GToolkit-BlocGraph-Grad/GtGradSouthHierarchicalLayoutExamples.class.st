Class {
	#name : #GtGradSouthHierarchicalLayoutExamples,
	#superclass : #GtGradHierarchicalLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'examples - layout' }
GtGradSouthHierarchicalLayoutExamples >> allNodesHaveIncomingEdges [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createGraphWithAllNodesHaveIncomingEdges.
	aLayout := self layout.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {25 @ 140 corner: 75 @ 160.
				55 @ 70 corner: 105 @ 90.
				83 @ 0 corner: 133 @ 20.
				53 @ 210 corner: 103 @ 230.
				0 @ 0 corner: 50 @ 20}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradSouthHierarchicalLayoutExamples >> disconnectedGraph [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createDisconnectedGraph.
	aLayout := self layout.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {0 @ 210 corner: 50 @ 230.
				0 @ 140 corner: 50 @ 160.
				0 @ 70 corner: 50 @ 90.
				0 @ 0 corner: 50 @ 20.
				110 @ 210 corner: 160 @ 230.
				110 @ 140 corner: 160 @ 160.
				110 @ 70 corner: 160 @ 90}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradSouthHierarchicalLayoutExamples >> disconnectedGraphIncreasedInterHierarchySpacing [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createDisconnectedGraph.
	aLayout := self layout.
	aLayout interHierarchySpacing: 100.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {0 @ 210 corner: 50 @ 230.
				0 @ 140 corner: 50 @ 160.
				0 @ 70 corner: 50 @ 90.
				0 @ 0 corner: 50 @ 20.
				150 @ 210 corner: 200 @ 230.
				150 @ 140 corner: 200 @ 160.
				150 @ 70 corner: 200 @ 90}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradSouthHierarchicalLayoutExamples >> graphWithIncreasedInterRanksSpacing [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createGraphWithAllMultipleRanks.
	aLayout := self layout.
	aLayout interRanksSpacing: 70.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {25 @ 180 corner: 75 @ 200.
				55 @ 90 corner: 105 @ 110.
				83 @ 0 corner: 133 @ 20.
				53 @ 270 corner: 103 @ 290.
				0 @ 0 corner: 50 @ 20}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradSouthHierarchicalLayoutExamples >> graphWithIncreasedIntraRankSpacing [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createGraphWithAllMultipleRanks.
	aLayout := self layout.
	aLayout intraRankSpacing: 100.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {25 @ 140 corner: 75 @ 160.
				125 @ 70 corner: 175 @ 90.
				188 @ 0 corner: 238 @ 20.
				88 @ 210 corner: 138 @ 230.
				0 @ 0 corner: 50 @ 20}.

	^ aParentNode
]

{ #category : #'examples - instance creation' }
GtGradSouthHierarchicalLayoutExamples >> layout [
	^ GtGradSouthHierarchicalLayout new
]

{ #category : #'examples - layout' }
GtGradSouthHierarchicalLayoutExamples >> simpleGraph [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createSimpleGraph.
	aLayout := self layout.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {2 @ 420 corner: 52 @ 440.
				2 @ 350 corner: 52 @ 370.
				0 @ 70 corner: 50 @ 90.
				0 @ 0 corner: 50 @ 20.
				29 @ 280 corner: 79 @ 300.
				29 @ 210 corner: 79 @ 230.
				29 @ 140 corner: 79 @ 160}.

	^ aParentNode
]
