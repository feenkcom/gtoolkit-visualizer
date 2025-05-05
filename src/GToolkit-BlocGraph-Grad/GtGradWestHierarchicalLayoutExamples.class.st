Class {
	#name : #GtGradWestHierarchicalLayoutExamples,
	#superclass : #GtGradHierarchicalLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'examples - layout' }
GtGradWestHierarchicalLayoutExamples >> allNodesHaveIncomingEdges [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createGraphWithAllNodesHaveIncomingEdges.
	aLayout := self layout.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {100 @ 10 corner: 150 @ 30.
				200 @ 40 corner: 250 @ 60.
				300 @ 60 corner: 350 @ 80.
				0 @ 30 corner: 50 @ 50.
				300 @ 0 corner: 350 @ 20}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradWestHierarchicalLayoutExamples >> disconnectedGraph [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createDisconnectedGraph.
	aLayout := self layout.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {0 @ 0 corner: 50 @ 20.
				100 @ 0 corner: 150 @ 20.
				200 @ 0 corner: 250 @ 20.
				300 @ 0 corner: 350 @ 20.
				0 @ 80 corner: 50 @ 100.
				100 @ 80 corner: 150 @ 100.
				200 @ 80 corner: 250 @ 100}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradWestHierarchicalLayoutExamples >> disconnectedGraphIncreasedInterHierarchySpacing [
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
				100 @ 0 corner: 150 @ 20.
				200 @ 0 corner: 250 @ 20.
				300 @ 0 corner: 350 @ 20.
				0 @ 120 corner: 50 @ 140.
				100 @ 120 corner: 150 @ 140.
				200 @ 120 corner: 250 @ 140}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradWestHierarchicalLayoutExamples >> graphWithIncreasedInterRanksSpacing [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createGraphWithAllMultipleRanks.
	aLayout := self layout.
	aLayout interRanksSpacing: 70.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {120 @ 10 corner: 170 @ 30.
				240 @ 40 corner: 290 @ 60.
				360 @ 60 corner: 410 @ 80.
				0 @ 30 corner: 50 @ 50.
				360 @ 0 corner: 410 @ 20}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradWestHierarchicalLayoutExamples >> graphWithIncreasedIntraRankSpacing [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createGraphWithAllMultipleRanks.
	aLayout := self layout.
	aLayout intraRankSpacing: 100.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {100 @ 10 corner: 150 @ 30.
				200 @ 110 corner: 250 @ 130.
				300 @ 165 corner: 350 @ 185.
				0 @ 65 corner: 50 @ 85.
				300 @ 0 corner: 350 @ 20}.

	^ aParentNode
]

{ #category : #'examples - instance creation' }
GtGradWestHierarchicalLayoutExamples >> layout [
	^ GtGradWestHierarchicalLayout new
]

{ #category : #'examples - layout' }
GtGradWestHierarchicalLayoutExamples >> simpleGraph [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createSimpleGraph.
	aLayout := self layout.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {0 @ 2 corner: 50 @ 22.
				100 @ 2 corner: 150 @ 22.
				500 @ 1 corner: 550 @ 21.
				600 @ 0 corner: 650 @ 20.
				200 @ 22 corner: 250 @ 42.
				300 @ 22 corner: 350 @ 42.
				400 @ 22 corner: 450 @ 42}.

	^ aParentNode
]
