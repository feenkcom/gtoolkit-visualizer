Class {
	#name : #GtGradVerticalDominanceTreeLayoutExamples,
	#superclass : #GtGradDominanceTreeLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'example - layout' }
GtGradVerticalDominanceTreeLayoutExamples >> compactSubtrees [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructTreeWithNodesWithAndWithoutChildrenOnTheSameLevel.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout separateSubtrees: false.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {104.0 @ 0.0 corner: 154.0 @ 20.0.
				52.0 @ 31.0 corner: 102.0 @ 51.0.
				104.0 @ 31.0 corner: 154.0 @ 51.0.
				156.0 @ 31.0 corner: 206.0 @ 51.0.
				0.0 @ 62.0 corner: 50.0 @ 82.0.
				52.0 @ 62.0 corner: 102.0 @ 82.0.
				104.0 @ 62.0 corner: 154.0 @ 82.0}.

	^ aParentNode
]

{ #category : #'example - instance creation' }
GtGradVerticalDominanceTreeLayoutExamples >> dominanceTreeLayout [
	<gtExample>
	<return: #GtGradVerticalDominanceTreeLayout>
	| aTreeLayout |
	aTreeLayout := GtGradVerticalDominanceTreeLayout new.
	self assert: aTreeLayout levelDistance equals: 10.
	self assert: aTreeLayout nodeDistance equals: 1.

	^ aTreeLayout
]

{ #category : #'example - layout' }
GtGradVerticalDominanceTreeLayoutExamples >> dominanceTreeWith4NodeCycle [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructDominanceTreeWith4NodeCycle.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {0.0 @ 0.0 corner: 50.0 @ 20.0.
				0.0 @ 31.0 corner: 50.0 @ 51.0.
				0.0 @ 62.0 corner: 50.0 @ 82.0.
				0.0 @ 93.0 corner: 50.0 @ 113.0}.

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradVerticalDominanceTreeLayoutExamples >> dominanceTreeWith4NodeCycleAndSeparateSubtree [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructDominanceTreeWith4NodeCycleAndSeparateSubtree.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {80.0 @ 0.0 corner: 130.0 @ 20.0.
				80.0 @ 31.0 corner: 130.0 @ 51.0.
				80.0 @ 62.0 corner: 130.0 @ 82.0.
				80.0 @ 93.0 corner: 130.0 @ 113.0.
				0.0 @ 0.0 corner: 50.0 @ 20.0.
				0.0 @ 31.0 corner: 50.0 @ 51.0}.

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradVerticalDominanceTreeLayoutExamples >> dominanceTreeWithMultiplePathsToANodesWith8Nodes [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructDominanceTreeWithMultiplePathsToANodesWith8Nodes.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {26.0 @ 0.0 corner: 76.0 @ 20.0.
				0.0 @ 31.0 corner: 50.0 @ 51.0.
				52.0 @ 31.0 corner: 102.0 @ 51.0.
				52.0 @ 62.0 corner: 102.0 @ 82.0.
				52.0 @ 93.0 corner: 102.0 @ 113.0.
				52.0 @ 124.0 corner: 102.0 @ 144.0.
				52.0 @ 155.0 corner: 102.0 @ 175.0.
				52.0 @ 186.0 corner: 102.0 @ 206.0}.

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradVerticalDominanceTreeLayoutExamples >> dominanceTreeWithMultiplePathsToANodesWith9Nodes [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructDominanceTreeWithMultiplePathsToANodesWith9Nodes.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {65.0 @ 0.0 corner: 115.0 @ 20.0.
				26.0 @ 31.0 corner: 76.0 @ 51.0.
				104.0 @ 31.0 corner: 154.0 @ 51.0.
				0.0 @ 62.0 corner: 50.0 @ 82.0.
				104.0 @ 62.0 corner: 154.0 @ 82.0.
				104.0 @ 93.0 corner: 154.0 @ 113.0.
				104.0 @ 124.0 corner: 154.0 @ 144.0.
				104.0 @ 155.0 corner: 154.0 @ 175.0.
				52.0 @ 62.0 corner: 102.0 @ 82.0}.

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradVerticalDominanceTreeLayoutExamples >> dominanceTreeWithMultiplePathsToANodesWith9NodesAndACycle [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self
			constructDominanceTreeWithMultiplePathsToANodesWith9NodesAndACycle.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {65.0 @ 0.0 corner: 115.0 @ 20.0.
				26.0 @ 31.0 corner: 76.0 @ 51.0.
				104.0 @ 31.0 corner: 154.0 @ 51.0.
				0.0 @ 62.0 corner: 50.0 @ 82.0.
				104.0 @ 62.0 corner: 154.0 @ 82.0.
				104.0 @ 93.0 corner: 154.0 @ 113.0.
				104.0 @ 124.0 corner: 154.0 @ 144.0.
				104.0 @ 155.0 corner: 154.0 @ 175.0.
				52.0 @ 62.0 corner: 102.0 @ 82.0}.

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradVerticalDominanceTreeLayoutExamples >> graphWithANodeWithSeveralIncomingEdges [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructGraphWithANodeWithSeveralIncomingEdges.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {78.0 @ 0.0 corner: 128.0 @ 20.0.
				0.0 @ 31.0 corner: 50.0 @ 51.0.
				52.0 @ 31.0 corner: 102.0 @ 51.0.
				104.0 @ 31.0 corner: 154.0 @ 51.0.
				156.0 @ 31.0 corner: 206.0 @ 51.0.
				0.0 @ 62.0 corner: 50.0 @ 82.0}.

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradVerticalDominanceTreeLayoutExamples >> separatedSubtrees [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructTreeWithNodesWithAndWithoutChildrenOnTheSameLevel.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout separateSubtrees: true.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {130.0 @ 0.0 corner: 180.0 @ 20.0.
				52.0 @ 31.0 corner: 102.0 @ 51.0.
				156.0 @ 31.0 corner: 206.0 @ 51.0.
				208.0 @ 31.0 corner: 258.0 @ 51.0.
				0.0 @ 62.0 corner: 50.0 @ 82.0.
				52.0 @ 62.0 corner: 102.0 @ 82.0.
				104.0 @ 62.0 corner: 154.0 @ 82.0}.

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradVerticalDominanceTreeLayoutExamples >> simpleDominanceTreeWith5Nodes [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructDominanceTreeWith5Nodes.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {26.0 @ 0.0 corner: 76.0 @ 20.0.
				0.0 @ 31.0 corner: 50.0 @ 51.0.
				52.0 @ 31.0 corner: 102.0 @ 51.0.
				52.0 @ 62.0 corner: 102.0 @ 82.0.
				52.0 @ 93.0 corner: 102.0 @ 113.0}.

	^ aParentNode
]
