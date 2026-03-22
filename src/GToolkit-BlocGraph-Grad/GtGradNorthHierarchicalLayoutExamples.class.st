Class {
	#name : #GtGradNorthHierarchicalLayoutExamples,
	#superclass : #GtGradHierarchicalLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'examples - layout' }
GtGradNorthHierarchicalLayoutExamples >> allNodesHaveIncomingEdges [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createGraphWithAllNodesHaveIncomingEdges.
	aLayout := self layout.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {25 @ 70 corner: 75 @ 90.
				55 @ 140 corner: 105 @ 160.
				83 @ 210 corner: 133 @ 230.
				53 @ 0 corner: 103 @ 20.
				0 @ 210 corner: 50 @ 230}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradNorthHierarchicalLayoutExamples >> disconnectedGraph [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createDisconnectedGraph.
	aLayout := self layout.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {0 @ 0 corner: 50 @ 20.
				0 @ 70 corner: 50 @ 90.
				0 @ 140 corner: 50 @ 160.
				0 @ 210 corner: 50 @ 230.
				110 @ 0 corner: 160 @ 20.
				110 @ 70 corner: 160 @ 90.
				110 @ 140 corner: 160 @ 160}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradNorthHierarchicalLayoutExamples >> disconnectedGraphIncreasedInterHierarchySpacing [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createDisconnectedGraph.
	aLayout := self layout.
	aLayout interHierarchySpacing: 100.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {0 @ 0 corner: 50 @ 20.
				0 @ 70 corner: 50 @ 90.
				0 @ 140 corner: 50 @ 160.
				0 @ 210 corner: 50 @ 230.
				150 @ 0 corner: 200 @ 20.
				150 @ 70 corner: 200 @ 90.
				150 @ 140 corner: 200 @ 160}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradNorthHierarchicalLayoutExamples >> graphWithIncreasedInterRanksSpacing [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createGraphWithAllMultipleRanks.
	aLayout := self layout.
	aLayout interRanksSpacing: 70.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {25 @ 90 corner: 75 @ 110.
				55 @ 180 corner: 105 @ 200.
				83 @ 270 corner: 133 @ 290.
				53 @ 0 corner: 103 @ 20.
				0 @ 270 corner: 50 @ 290}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradNorthHierarchicalLayoutExamples >> graphWithIncreasedIntraRankSpacing [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createGraphWithAllMultipleRanks.
	aLayout := self layout.
	aLayout intraRankSpacing: 100.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {25 @ 70 corner: 75 @ 90.
				125 @ 140 corner: 175 @ 160.
				188 @ 210 corner: 238 @ 230.
				88 @ 0 corner: 138 @ 20.
				0 @ 210 corner: 50 @ 230}.

	^ aParentNode
]

{ #category : #'examples - instance creation' }
GtGradNorthHierarchicalLayoutExamples >> layout [
	^ GtGradNorthHierarchicalLayout new
]

{ #category : #'examples - layout' }
GtGradNorthHierarchicalLayoutExamples >> simpleGraph [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createSimpleGraph.
	aLayout := self layout.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {2 @ 0 corner: 52 @ 20.
				2 @ 70 corner: 52 @ 90.
				0 @ 350 corner: 50 @ 370.
				0 @ 420 corner: 50 @ 440.
				29 @ 140 corner: 79 @ 160.
				29 @ 210 corner: 79 @ 230.
				29 @ 280 corner: 79 @ 300}.

	^ aParentNode
]
