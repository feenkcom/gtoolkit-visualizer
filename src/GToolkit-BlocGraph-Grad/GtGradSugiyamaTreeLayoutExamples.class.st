Class {
	#name : #GtGradSugiyamaTreeLayoutExamples,
	#superclass : #GtGradTreeLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #accessing }
GtGradSugiyamaTreeLayoutExamples >> binaryTreeWith15Nodes [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructBinaryTreeWith15Nodes.

	aTreeLayout := self treeLayout.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {188.5 @ 3.0 corner: 238.5 @ 23.0.
				215.0 @ 43.0 corner: 265.0 @ 63.0.
				162.0 @ 43.0 corner: 212.0 @ 63.0.
				268.0 @ 83.0 corner: 318.0 @ 103.0.
				215.0 @ 83.0 corner: 265.0 @ 103.0.
				162.0 @ 83.0 corner: 212.0 @ 103.0.
				109.0 @ 83.0 corner: 159.0 @ 103.0.
				374.0 @ 123.0 corner: 424.0 @ 143.0.
				321.0 @ 123.0 corner: 371.0 @ 143.0.
				268.0 @ 123.0 corner: 318.0 @ 143.0.
				215.0 @ 123.0 corner: 265.0 @ 143.0.
				162.0 @ 123.0 corner: 212.0 @ 143.0.
				109.0 @ 123.0 corner: 159.0 @ 143.0.
				56.0 @ 123.0 corner: 106.0 @ 143.0.
				3.0 @ 123.0 corner: 53.0 @ 143.0}.
	^ aParentNode
]

{ #category : #accessing }
GtGradSugiyamaTreeLayoutExamples >> binaryTreeWith15NodesReversed [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructBinaryTreeWith15Nodes.

	aTreeLayout := self treeLayout reverse: true.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {188.5 @ 123.0 corner: 238.5 @ 143.0.
				215.0 @ 83.0 corner: 265.0 @ 103.0.
				162.0 @ 83.0 corner: 212.0 @ 103.0.
				268.0 @ 43.0 corner: 318.0 @ 63.0.
				215.0 @ 43.0 corner: 265.0 @ 63.0.
				162.0 @ 43.0 corner: 212.0 @ 63.0.
				109.0 @ 43.0 corner: 159.0 @ 63.0.
				374.0 @ 3.0 corner: 424.0 @ 23.0.
				321.0 @ 3.0 corner: 371.0 @ 23.0.
				268.0 @ 3.0 corner: 318.0 @ 23.0.
				215.0 @ 3.0 corner: 265.0 @ 23.0.
				162.0 @ 3.0 corner: 212.0 @ 23.0.
				109.0 @ 3.0 corner: 159.0 @ 23.0.
				56.0 @ 3.0 corner: 106.0 @ 23.0.
				3.0 @ 3.0 corner: 53.0 @ 23.0}.

	^ aParentNode
]

{ #category : #accessing }
GtGradSugiyamaTreeLayoutExamples >> binaryTreeWith7Nodes [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructBinaryTreeWith7Nodes.

	aTreeLayout := self treeLayout.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {82.5 @ 3.0 corner: 132.5 @ 23.0.
				109.0 @ 43.0 corner: 159.0 @ 63.0.
				56.0 @ 43.0 corner: 106.0 @ 63.0.
				162.0 @ 83.0 corner: 212.0 @ 103.0.
				109.0 @ 83.0 corner: 159.0 @ 103.0.
				56.0 @ 83.0 corner: 106.0 @ 103.0.
				3.0 @ 83.0 corner: 53.0 @ 103.0}.

	^ aParentNode
]

{ #category : #accessing }
GtGradSugiyamaTreeLayoutExamples >> binaryTreeWith7NodesReversed [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructBinaryTreeWith7Nodes.

	aTreeLayout := self treeLayout reverse: true.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {82.5 @ 83.0 corner: 132.5 @ 103.0.
				109.0 @ 43.0 corner: 159.0 @ 63.0.
				56.0 @ 43.0 corner: 106.0 @ 63.0.
				162.0 @ 3.0 corner: 212.0 @ 23.0.
				109.0 @ 3.0 corner: 159.0 @ 23.0.
				56.0 @ 3.0 corner: 106.0 @ 23.0.
				3.0 @ 3.0 corner: 53.0 @ 23.0}.

	^ aParentNode
]

{ #category : #accessing }
GtGradSugiyamaTreeLayoutExamples >> compactSubtrees [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructTreeWithNodesWithAndWithoutChildrenOnTheSameLevel.

	aTreeLayout := self treeLayout.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {56.0 @ 3.0 corner: 106.0 @ 23.0.
				109.0 @ 43.0 corner: 159.0 @ 63.0.
				56.0 @ 43.0 corner: 106.0 @ 63.0.
				3.0 @ 43.0 corner: 53.0 @ 63.0.
				109.0 @ 83.0 corner: 159.0 @ 103.0.
				56.0 @ 83.0 corner: 106.0 @ 103.0.
				3.0 @ 83.0 corner: 53.0 @ 103.0}.

	^ aParentNode
]

{ #category : #accessing }
GtGradSugiyamaTreeLayoutExamples >> disconnectedGraph [
	<gtExample>
	<noTest>
	| aParentNode aTreeLayout |

	aParentNode := self constructDisconnectedGraph.
	aTreeLayout := self treeLayout.
	
	aTreeLayout measure: aParentNode.
	
	"self assert: aParentNode children layoutBounds equals: {
		(0.0@11.0) corner: (50.0@31.0).
		(61.0@11.0) corner: (111.0@31.0).
		(183.0@22.0) corner: (233.0@42.0).
		(122.0@0.0) corner: (172.0@20.0).
		(122.0@22.0) corner: (172.0@42.0).
		(244.0@11.0) corner: (294.0@31.0).
		(244.0@33.0) corner: (294.0@53.0).
		(0.0@94.0) corner: (50.0@114.0).
		(61.0@83.0) corner: (111.0@103.0).
		(61.0@105.0) corner: (111.0@125.0).
		(122.0@105.0) corner: (172.0@125.0).
		(183.0@105.0) corner: (233.0@125.0)
	}."
	
	^ aParentNode
]

{ #category : #accessing }
GtGradSugiyamaTreeLayoutExamples >> treeLayout [
	<gtExample>
	<return: #GtGradSugiyamaTreeLayout>
	| aTreeLayout |
	aTreeLayout := GtGradSugiyamaTreeLayout new.
	self assert: aTreeLayout horizontalGap equals: 3.
	self assert: aTreeLayout verticalGap equals: 20.

	^ aTreeLayout
]
