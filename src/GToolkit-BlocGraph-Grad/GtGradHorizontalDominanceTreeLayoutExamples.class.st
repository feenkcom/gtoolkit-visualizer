Class {
	#name : #GtGradHorizontalDominanceTreeLayoutExamples,
	#superclass : #GtGradDominanceTreeLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'example - layout' }
GtGradHorizontalDominanceTreeLayoutExamples >> compactSubtrees [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructTreeWithNodesWithAndWithoutChildrenOnTheSameLevel.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout separateSubtrees: false.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {0.0 @ 44.0 corner: 50.0 @ 64.0.
				61.0 @ 22.0 corner: 111.0 @ 42.0.
				61.0 @ 44.0 corner: 111.0 @ 64.0.
				61.0 @ 66.0 corner: 111.0 @ 86.0.
				122.0 @ 0.0 corner: 172.0 @ 20.0.
				122.0 @ 22.0 corner: 172.0 @ 42.0.
				122.0 @ 44.0 corner: 172.0 @ 64.0}.

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradHorizontalDominanceTreeLayoutExamples >> deepestParentInForestExample [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self
			createGraph: 6
			pairs: {1 -> 2.
					6 -> 2.
					6 -> 3.
					6 -> 4.
					3 -> 2.
					4 -> 5}.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout separateSubtrees: false.
	aTreeLayout measure: aParentNode.
	self
		assert: aParentNode children layoutBounds
		equals: {0.0 @ 0.0 corner: 50.0 @ 20.0.
				122.0 @ 50.0 corner: 172.0 @ 70.0.
				61.0 @ 50.0 corner: 111.0 @ 70.0.
				61.0 @ 72.0 corner: 111.0 @ 92.0.
				122.0 @ 72.0 corner: 172.0 @ 92.0.
				0.0 @ 61.0 corner: 50.0 @ 81.0}.

	^ aParentNode
]

{ #category : #'example - instance creation' }
GtGradHorizontalDominanceTreeLayoutExamples >> dominanceTreeLayout [
	<gtExample>
	<return: #GtGradHorizontalDominanceTreeLayout>
	| aTreeLayout |
	aTreeLayout := GtGradHorizontalDominanceTreeLayout new.
	self assert: aTreeLayout levelDistance equals: 10.
	self assert: aTreeLayout nodeDistance equals: 1.

	^ aTreeLayout
]

{ #category : #'example - layout' }
GtGradHorizontalDominanceTreeLayoutExamples >> dominanceTreeWith4NodeCycle [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructDominanceTreeWith4NodeCycle.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {0.0 @ 0.0 corner: 50.0 @ 20.0.
				61.0 @ 0.0 corner: 111.0 @ 20.0.
				122.0 @ 0.0 corner: 172.0 @ 20.0.
				183.0 @ 0.0 corner: 233.0 @ 20.0}.

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradHorizontalDominanceTreeLayoutExamples >> dominanceTreeWith4NodeCycleAndSeparateSubtree [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructDominanceTreeWith4NodeCycleAndSeparateSubtree.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {0.0 @ 50.0 corner: 50.0 @ 70.0.
				61.0 @ 50.0 corner: 111.0 @ 70.0.
				122.0 @ 50.0 corner: 172.0 @ 70.0.
				183.0 @ 50.0 corner: 233.0 @ 70.0.
				0.0 @ 0.0 corner: 50.0 @ 20.0.
				61.0 @ 0.0 corner: 111.0 @ 20.0}.

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradHorizontalDominanceTreeLayoutExamples >> dominanceTreeWithMultiplePathsToANodesWith8Nodes [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructDominanceTreeWithMultiplePathsToANodesWith8Nodes.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {0.0 @ 11.0 corner: 50.0 @ 31.0.
				61.0 @ 0.0 corner: 111.0 @ 20.0.
				61.0 @ 22.0 corner: 111.0 @ 42.0.
				122.0 @ 22.0 corner: 172.0 @ 42.0.
				183.0 @ 22.0 corner: 233.0 @ 42.0.
				244.0 @ 22.0 corner: 294.0 @ 42.0.
				305.0 @ 22.0 corner: 355.0 @ 42.0.
				366.0 @ 22.0 corner: 416.0 @ 42.0}.

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradHorizontalDominanceTreeLayoutExamples >> dominanceTreeWithMultiplePathsToANodesWith9Nodes [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructDominanceTreeWithMultiplePathsToANodesWith9Nodes.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {0.0 @ 27.5 corner: 50.0 @ 47.5.
				61.0 @ 11.0 corner: 111.0 @ 31.0.
				61.0 @ 44.0 corner: 111.0 @ 64.0.
				122.0 @ 0.0 corner: 172.0 @ 20.0.
				122.0 @ 44.0 corner: 172.0 @ 64.0.
				183.0 @ 44.0 corner: 233.0 @ 64.0.
				244.0 @ 44.0 corner: 294.0 @ 64.0.
				305.0 @ 44.0 corner: 355.0 @ 64.0.
				122.0 @ 22.0 corner: 172.0 @ 42.0}.

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradHorizontalDominanceTreeLayoutExamples >> dominanceTreeWithMultiplePathsToANodesWith9NodesAndACycle [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self
			constructDominanceTreeWithMultiplePathsToANodesWith9NodesAndACycle.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {0.0 @ 27.5 corner: 50.0 @ 47.5.
				61.0 @ 11.0 corner: 111.0 @ 31.0.
				61.0 @ 44.0 corner: 111.0 @ 64.0.
				122.0 @ 0.0 corner: 172.0 @ 20.0.
				122.0 @ 44.0 corner: 172.0 @ 64.0.
				183.0 @ 44.0 corner: 233.0 @ 64.0.
				244.0 @ 44.0 corner: 294.0 @ 64.0.
				305.0 @ 44.0 corner: 355.0 @ 64.0.
				122.0 @ 22.0 corner: 172.0 @ 42.0}.

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradHorizontalDominanceTreeLayoutExamples >> graphWithANodeWithSeveralIncomingEdges [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructGraphWithANodeWithSeveralIncomingEdges.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {0.0 @ 33.0 corner: 50.0 @ 53.0.
				61.0 @ 0.0 corner: 111.0 @ 20.0.
				61.0 @ 22.0 corner: 111.0 @ 42.0.
				61.0 @ 44.0 corner: 111.0 @ 64.0.
				61.0 @ 66.0 corner: 111.0 @ 86.0.
				122.0 @ 0.0 corner: 172.0 @ 20.0}.

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradHorizontalDominanceTreeLayoutExamples >> separatedSubtrees [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructTreeWithNodesWithAndWithoutChildrenOnTheSameLevel.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout separateSubtrees: true.
	aTreeLayout measure: aParentNode.	"self assert: aParentNode children layoutBounds equals: {
		(0.0@55.0) corner: (50.0@75.0).
		(61.0@22.0) corner: (111.0@42.0).
		(61.0@66.0) corner: (111.0@86.0).
		(61.0@88.0) corner: (111.0@108.0).
		(122.0@0.0) corner: (172.0@20.0).
		(122.0@22.0) corner: (172.0@42.0).
		(122.0@44.0) corner: (172.0@64.0)
	}."

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradHorizontalDominanceTreeLayoutExamples >> simpleDominanceTreeWith5Nodes [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructDominanceTreeWith5Nodes.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {0.0 @ 11.0 corner: 50.0 @ 31.0.
				61.0 @ 0.0 corner: 111.0 @ 20.0.
				61.0 @ 22.0 corner: 111.0 @ 42.0.
				122.0 @ 22.0 corner: 172.0 @ 42.0.
				183.0 @ 22.0 corner: 233.0 @ 42.0}.

	^ aParentNode
]
