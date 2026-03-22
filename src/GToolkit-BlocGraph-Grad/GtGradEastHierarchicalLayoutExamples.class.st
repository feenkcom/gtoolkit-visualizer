Class {
	#name : #GtGradEastHierarchicalLayoutExamples,
	#superclass : #GtGradHierarchicalLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'examples - layout' }
GtGradEastHierarchicalLayoutExamples >> allNodesHaveIncomingEdges [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createGraphWithAllNodesHaveIncomingEdges.
	aLayout := self layout.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {200 @ 10 corner: 250 @ 30.
				100 @ 40 corner: 150 @ 60.
				0 @ 60 corner: 50 @ 80.
				300 @ 30 corner: 350 @ 50.
				0 @ 0 corner: 50 @ 20}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradEastHierarchicalLayoutExamples >> disconnectedGraph [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createDisconnectedGraph.
	aLayout := self layout.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {300 @ 0 corner: 350 @ 20.
				200 @ 0 corner: 250 @ 20.
				100 @ 0 corner: 150 @ 20.
				0 @ 0 corner: 50 @ 20.
				300 @ 80 corner: 350 @ 100.
				200 @ 80 corner: 250 @ 100.
				100 @ 80 corner: 150 @ 100}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradEastHierarchicalLayoutExamples >> disconnectedGraphIncreasedInterHierarchySpacing [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createDisconnectedGraph.
	aLayout := self layout.
	aLayout interHierarchySpacing: 100.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {300 @ 0 corner: 350 @ 20.
				200 @ 0 corner: 250 @ 20.
				100 @ 0 corner: 150 @ 20.
				0 @ 0 corner: 50 @ 20.
				300 @ 120 corner: 350 @ 140.
				200 @ 120 corner: 250 @ 140.
				100 @ 120 corner: 150 @ 140}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradEastHierarchicalLayoutExamples >> graphWithIncreasedInterRanksSpacing [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createGraphWithAllMultipleRanks.
	aLayout := self layout.
	aLayout interRanksSpacing: 70.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {240 @ 10 corner: 290 @ 30.
				120 @ 40 corner: 170 @ 60.
				0 @ 60 corner: 50 @ 80.
				360 @ 30 corner: 410 @ 50.
				0 @ 0 corner: 50 @ 20}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradEastHierarchicalLayoutExamples >> graphWithIncreasedIntraRankSpacing [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createGraphWithAllMultipleRanks.
	aLayout := self layout.
	aLayout intraRankSpacing: 100.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {200 @ 10 corner: 250 @ 30.
				100 @ 110 corner: 150 @ 130.
				0 @ 165 corner: 50 @ 185.
				300 @ 65 corner: 350 @ 85.
				0 @ 0 corner: 50 @ 20}.

	^ aParentNode
]

{ #category : #'examples - instance creation' }
GtGradEastHierarchicalLayoutExamples >> layout [
	^ GtGradEastHierarchicalLayout new
]

{ #category : #'examples - layout' }
GtGradEastHierarchicalLayoutExamples >> simpleGraph [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createSimpleGraph.
	aLayout := self layout.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {600 @ 2 corner: 650 @ 22.
				500 @ 2 corner: 550 @ 22.
				100 @ 1 corner: 150 @ 21.
				0 @ 0 corner: 50 @ 20.
				400 @ 22 corner: 450 @ 42.
				300 @ 22 corner: 350 @ 42.
				200 @ 22 corner: 250 @ 42}.

	^ aParentNode
]
