Class {
	#name : #GtGradAbstractTreeCreationExamples,
	#superclass : #GtGradLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'examples - dominance tree' }
GtGradAbstractTreeCreationExamples >> centeredDominanceTreesCreation [
	<gtExample>
	<return: #GtGradTreeNode>
	| theNodes trees root level1Node1 level1Node2 level1Node3 level1Node4 level2Node1 level2Node2 level3Node1 level3Node2 level3Node3 |
	theNodes := self createGraphForCenteredDominanceTree children.

	trees := (GtGradDominanceCenteredTreeForest
			from: theNodes
			separateSubtrees: true) trees.
	self assert: trees size equals: 1.
	self
		assert: (self getNumberOfNodesOfForest: trees)
		equals: theNodes size + (self getNumberOfLeavesOfForest: trees).

	root := trees first.

	self assert: root element equals: (theNodes at: 1).
	self assert: root nodes size equals: 4.
	level1Node1 := root nodes at: 1.
	level1Node2 := root nodes at: 2.
	level1Node3 := root nodes at: 3.
	level1Node4 := root nodes at: 4.
	self assert: level1Node1 element equals: (theNodes at: 2).
	self assert: level1Node2 element equals: (theNodes at: 3).
	self assert: level1Node3 element equals: (theNodes at: 4).
	self assert: level1Node4 element equals: (theNodes at: 5).
	self assert: level1Node1 nodes size equals: 1.
	self assert: level1Node2 nodes size equals: 1.
	self assert: level1Node3 nodes size equals: 1.
	self assert: level1Node4 nodes size equals: 1.

	level2Node1 := level1Node1 nodes at: 1.
	level2Node2 := level1Node2 nodes at: 1.
	self assert: level2Node1 element equals: (theNodes at: 10).
	self assert: level2Node1 nodes size equals: 1.
	self assert: level2Node2 element equals: (theNodes at: 6).
	self assert: level2Node2 nodes size equals: 2.

	level3Node1 := level2Node1 nodes at: 1.
	level3Node2 := level2Node2 nodes at: 1.
	level3Node3 := level2Node2 nodes at: 2.
	self assert: level3Node1 element equals: (theNodes at: 11).
	self assert: level3Node2 element equals: (theNodes at: 7).
	self assert: level3Node3 element equals: (theNodes at: 8).
	self assert: level3Node1 nodes size equals: 1.
	self assert: level3Node2 nodes size equals: 1.
	self assert: level3Node3 nodes size equals: 1.
	self assert: (level3Node2 nodes at: 1) element equals: (theNodes at: 9).

	^ root
]

{ #category : #'examples - graph creation' }
GtGradAbstractTreeCreationExamples >> createGraphForCenteredDominanceTree [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode theNodes |
	aParentNode := self
			createGraph: 11
			pairs: {1 -> 2.
					1 -> 3.
					1 -> 4.
					1 -> 5.
					2 -> 6.
					3 -> 6.
					4 -> 6.
					5 -> 6.
					6 -> 7.
					6 -> 8.
					2 -> 10.
					10 -> 11.
					11 -> 9.
					7 -> 9.
					8 -> 9}.

	theNodes := aParentNode children.

	self assert: (theNodes at: 1) nodesAlongOutgoingEdges size equals: 4.
	self assert: (theNodes at: 1) nodesAlongIncomingEdges size equals: 0.
	self assert: (theNodes at: 2) nodesAlongOutgoingEdges size equals: 2.
	self assert: (theNodes at: 2) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 3) nodesAlongOutgoingEdges size equals: 1.
	self assert: (theNodes at: 3) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 4) nodesAlongOutgoingEdges size equals: 1.
	self assert: (theNodes at: 4) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 5) nodesAlongOutgoingEdges size equals: 1.
	self assert: (theNodes at: 5) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 6) nodesAlongOutgoingEdges size equals: 2.
	self assert: (theNodes at: 6) nodesAlongIncomingEdges size equals: 4.
	self assert: (theNodes at: 7) nodesAlongOutgoingEdges size equals: 1.
	self assert: (theNodes at: 7) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 8) nodesAlongOutgoingEdges size equals: 1.
	self assert: (theNodes at: 8) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 9) nodesAlongOutgoingEdges size equals: 0.
	self assert: (theNodes at: 9) nodesAlongIncomingEdges size equals: 3.
	self assert: (theNodes at: 10) nodesAlongOutgoingEdges size equals: 1.
	self assert: (theNodes at: 10) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 11) nodesAlongOutgoingEdges size equals: 1.
	self assert: (theNodes at: 11) nodesAlongIncomingEdges size equals: 1.

	^ aParentNode
]

{ #category : #'examples - graph creation' }
GtGradAbstractTreeCreationExamples >> createGraphForComplexDominanceTree [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode theNodes |
	aParentNode := self
			createGraph: 9
			pairs: {1 -> 2.
					1 -> 3.
					2 -> 4.
					2 -> 7.
					2 -> 9.
					3 -> 5.
					5 -> 6.
					6 -> 7.
					7 -> 8.
					9 -> 8}.

	theNodes := aParentNode children.

	self assert: (theNodes at: 1) nodesAlongOutgoingEdges size equals: 2.
	self assert: (theNodes at: 1) nodesAlongIncomingEdges size equals: 0.
	self assert: (theNodes at: 2) nodesAlongOutgoingEdges size equals: 3.
	self assert: (theNodes at: 2) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 7) nodesAlongOutgoingEdges size equals: 1.
	self assert: (theNodes at: 7) nodesAlongIncomingEdges size equals: 2.
	self assert: (theNodes at: 8) nodesAlongOutgoingEdges size equals: 0.
	self assert: (theNodes at: 8) nodesAlongIncomingEdges size equals: 2.
	self assert: (theNodes at: 9) nodesAlongOutgoingEdges size equals: 1.
	self assert: (theNodes at: 9) nodesAlongIncomingEdges size equals: 1.

	^ aParentNode
]

{ #category : #'examples - graph creation' }
GtGradAbstractTreeCreationExamples >> createGraphForDepthFirstSearchForest [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode theNodes |
	aParentNode := self
			createGraph: 8
			pairs: {1 -> 2.
					1 -> 3.
					2 -> 4.
					2 -> 5.
					6 -> 7.
					6 -> 8}.

	theNodes := aParentNode children.

	self assert: (theNodes at: 1) nodesAlongOutgoingEdges size equals: 2.
	self assert: (theNodes at: 1) nodesAlongIncomingEdges size equals: 0.
	self assert: (theNodes at: 2) nodesAlongOutgoingEdges size equals: 2.
	self assert: (theNodes at: 2) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 3) nodesAlongOutgoingEdges size equals: 0.
	self assert: (theNodes at: 3) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 4) nodesAlongOutgoingEdges size equals: 0.
	self assert: (theNodes at: 4) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 5) nodesAlongOutgoingEdges size equals: 0.
	self assert: (theNodes at: 5) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 6) nodesAlongOutgoingEdges size equals: 2.
	self assert: (theNodes at: 6) nodesAlongIncomingEdges size equals: 0.
	self assert: (theNodes at: 7) nodesAlongOutgoingEdges size equals: 0.
	self assert: (theNodes at: 7) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 8) nodesAlongOutgoingEdges size equals: 0.
	self assert: (theNodes at: 8) nodesAlongIncomingEdges size equals: 1.

	^ aParentNode
]

{ #category : #'examples - graph creation' }
GtGradAbstractTreeCreationExamples >> createGraphForDepthFirstSearchTree [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode theNodes |
	aParentNode := self
			createGraph: 15
			pairs: {1 -> 2.
					1 -> 3.
					2 -> 4.
					2 -> 5.
					3 -> 6.
					3 -> 7.
					4 -> 8.
					4 -> 9.
					5 -> 10.
					5 -> 11.
					6 -> 12.
					6 -> 13.
					6 -> 14.
					6 -> 15}.

	theNodes := aParentNode children.

	self assert: (theNodes at: 1) nodesAlongOutgoingEdges size equals: 2.
	self assert: (theNodes at: 1) nodesAlongIncomingEdges size equals: 0.
	self assert: (theNodes at: 2) nodesAlongOutgoingEdges size equals: 2.
	self assert: (theNodes at: 2) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 6) nodesAlongOutgoingEdges size equals: 4.
	self assert: (theNodes at: 6) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 15) nodesAlongOutgoingEdges size equals: 0.
	self assert: (theNodes at: 15) nodesAlongIncomingEdges size equals: 1.

	^ aParentNode
]

{ #category : #'examples - graph creation' }
GtGradAbstractTreeCreationExamples >> createGraphForDepthFirstSearchWithCycles [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode theNodes |
	aParentNode := self
			createGraph: 7
			pairs: {1 -> 2.
					1 -> 3.
					2 -> 4.
					2 -> 5.
					3 -> 6.
					3 -> 7.
					6 -> 2.
					5 -> 3}.

	theNodes := aParentNode children.

	self assert: (theNodes at: 1) nodesAlongOutgoingEdges size equals: 2.
	self assert: (theNodes at: 1) nodesAlongIncomingEdges size equals: 0.
	self assert: (theNodes at: 2) nodesAlongOutgoingEdges size equals: 2.
	self assert: (theNodes at: 2) nodesAlongIncomingEdges size equals: 2.
	self assert: (theNodes at: 3) nodesAlongOutgoingEdges size equals: 2.
	self assert: (theNodes at: 3) nodesAlongIncomingEdges size equals: 2.
	self assert: (theNodes at: 4) nodesAlongOutgoingEdges size equals: 0.
	self assert: (theNodes at: 4) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 5) nodesAlongOutgoingEdges size equals: 1.
	self assert: (theNodes at: 5) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 6) nodesAlongOutgoingEdges size equals: 1.
	self assert: (theNodes at: 6) nodesAlongIncomingEdges size equals: 1.

	^ aParentNode
]

{ #category : #'examples - graph creation' }
GtGradAbstractTreeCreationExamples >> createGraphForDistinctDepthFirstSearchSubTrees [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode theNodes |
	aParentNode := self
			createGraph: 6
			pairs: {1 -> 2.
					1 -> 3.
					1 -> 4.
					2 -> 5.
					2 -> 6}.

	theNodes := aParentNode children.

	self assert: (theNodes at: 1) nodesAlongOutgoingEdges size equals: 3.
	self assert: (theNodes at: 1) nodesAlongIncomingEdges size equals: 0.
	self assert: (theNodes at: 2) nodesAlongOutgoingEdges size equals: 2.
	self assert: (theNodes at: 2) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 3) nodesAlongOutgoingEdges size equals: 0.
	self assert: (theNodes at: 3) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 4) nodesAlongOutgoingEdges size equals: 0.
	self assert: (theNodes at: 4) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 5) nodesAlongOutgoingEdges size equals: 0.
	self assert: (theNodes at: 5) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 6) nodesAlongOutgoingEdges size equals: 0.
	self assert: (theNodes at: 6) nodesAlongIncomingEdges size equals: 1.

	^ aParentNode
]

{ #category : #'examples - graph creation' }
GtGradAbstractTreeCreationExamples >> createGraphForDistinctDominanceSubTrees [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode theNodes |
	aParentNode := self
			createGraph: 6
			pairs: {1 -> 2.
					1 -> 3.
					1 -> 4.
					2 -> 5.
					2 -> 6.
					3 -> 5}.

	theNodes := aParentNode children.

	self assert: (theNodes at: 1) nodesAlongOutgoingEdges size equals: 3.
	self assert: (theNodes at: 1) nodesAlongIncomingEdges size equals: 0.
	self assert: (theNodes at: 2) nodesAlongOutgoingEdges size equals: 2.
	self assert: (theNodes at: 2) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 3) nodesAlongOutgoingEdges size equals: 1.
	self assert: (theNodes at: 3) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 4) nodesAlongOutgoingEdges size equals: 0.
	self assert: (theNodes at: 4) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 5) nodesAlongOutgoingEdges size equals: 0.
	self assert: (theNodes at: 5) nodesAlongIncomingEdges size equals: 2.
	self assert: (theNodes at: 6) nodesAlongOutgoingEdges size equals: 0.
	self assert: (theNodes at: 6) nodesAlongIncomingEdges size equals: 1.

	^ aParentNode
]

{ #category : #'examples - graph creation' }
GtGradAbstractTreeCreationExamples >> createGraphForSimpleDominanceTree [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode theNodes |
	aParentNode := self
			createGraph: 5
			pairs: {1 -> 2.
					1 -> 3.
					3 -> 4.
					4 -> 5.
					2 -> 5}.

	theNodes := aParentNode children.

	self assert: (theNodes at: 1) nodesAlongOutgoingEdges size equals: 2.
	self assert: (theNodes at: 1) nodesAlongIncomingEdges size equals: 0.
	self assert: (theNodes at: 2) nodesAlongOutgoingEdges size equals: 1.
	self assert: (theNodes at: 2) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 3) nodesAlongOutgoingEdges size equals: 1.
	self assert: (theNodes at: 3) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 4) nodesAlongOutgoingEdges size equals: 1.
	self assert: (theNodes at: 4) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 5) nodesAlongOutgoingEdges size equals: 0.
	self assert: (theNodes at: 5) nodesAlongIncomingEdges size equals: 2.

	^ aParentNode
]

{ #category : #'examples - graph creation' }
GtGradAbstractTreeCreationExamples >> createGraphWhoseNodesAreConnectedWithOtherTrees [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode theNodes |
	aParentNode := self
			createGraph: 9
			pairs: {1 -> 2.
					1 -> 3.
					2 -> 4.
					5 -> 6.
					7 -> 8.
					7 -> 9.
					6 -> 4.
					8 -> 4.
					9 -> 4}.

	theNodes := aParentNode children.

	self assert: (theNodes at: 1) nodesAlongOutgoingEdges size equals: 2.
	self assert: (theNodes at: 1) nodesAlongIncomingEdges size equals: 0.
	self assert: (theNodes at: 2) nodesAlongOutgoingEdges size equals: 1.
	self assert: (theNodes at: 2) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 3) nodesAlongOutgoingEdges size equals: 0.
	self assert: (theNodes at: 3) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 4) nodesAlongOutgoingEdges size equals: 0.
	self assert: (theNodes at: 4) nodesAlongIncomingEdges size equals: 4.
	self assert: (theNodes at: 5) nodesAlongOutgoingEdges size equals: 1.
	self assert: (theNodes at: 5) nodesAlongIncomingEdges size equals: 0.
	self assert: (theNodes at: 6) nodesAlongOutgoingEdges size equals: 1.
	self assert: (theNodes at: 6) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 7) nodesAlongIncomingEdges size equals: 0.
	self assert: (theNodes at: 7) nodesAlongOutgoingEdges size equals: 2.
	self assert: (theNodes at: 8) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 8) nodesAlongOutgoingEdges size equals: 1.
	self assert: (theNodes at: 9) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 9) nodesAlongOutgoingEdges size equals: 1.

	^ aParentNode
]

{ #category : #'examples - dominance tree' }
GtGradAbstractTreeCreationExamples >> distinctDominanceSubtrees [
	<gtExample>
	<return: #GtGradTreeNode>
	| theNodes trees root level1Node1 level1Node2 level1Node3 level2Node1 level2Node2 |
	theNodes := self createGraphForDistinctDominanceSubTrees children.

	trees := (GtGradDominanceTreeForest from: theNodes separateSubtrees: true)
			trees.
	self
		assert: (self getNumberOfNodesOfForest: trees)
		equals: theNodes size + (self getNumberOfLeavesOfForest: trees).
	self assert: trees size equals: 1.

	root := trees first.
	self assert: root element equals: (theNodes at: 1).
	self assert: root nodes size equals: 3.
	level1Node1 := root nodes at: 1.
	level1Node2 := root nodes at: 2.
	level1Node3 := root nodes at: 3.
	self assert: level1Node1 element equals: (theNodes at: 2).
	self assert: level1Node2 element equals: (theNodes at: 3).
	self assert: level1Node3 element equals: (theNodes at: 4).
	self assert: level1Node1 nodes size equals: 2.	"The following 2 nodes are actually leaves, but a tree node should be
	 added bellow each of them in order to force distinction of subtrees.
    Those additional nodes should not have any children "
	self assert: level1Node2 nodes size equals: 1.
	self assert: level1Node3 nodes size equals: 1.
	level2Node1 := level1Node1 nodes at: 1.
	self assert: level2Node1 element equals: (theNodes at: 5).
	self assert: level2Node1 nodes size equals: 1.
	self assert: (level2Node1 nodes at: 1) nodes size equals: 0.
	level2Node2 := level1Node1 nodes at: 2.
	self assert: level2Node2 element equals: (theNodes at: 6).
	self assert: level2Node1 nodes size equals: 1.
	self assert: (level2Node1 nodes at: 1) nodes size equals: 0.
	self assert: (level2Node1 nodes at: 1) nodes size equals: 0.
	self assert: (level2Node2 nodes at: 1) nodes size equals: 0.
	self assert: (level1Node3 nodes at: 1) nodes size equals: 0.

	^ root
]

{ #category : #'examples - depth-first search tree' }
GtGradAbstractTreeCreationExamples >> distinctSubtreesDFS [
	<gtExample>
	<return: #GtGradTreeNode>
	| theNodes trees root level1Node1 level1Node2 level1Node3 level2Node1 level2Node2 |
	theNodes := self createGraphForDistinctDepthFirstSearchSubTrees children.

	trees := (GtGradDFSTreeForest from: theNodes separateSubtrees: true) trees.
	self
		assert: (self getNumberOfNodesOfForest: trees)
		equals: theNodes size + (self getNumberOfLeavesOfForest: trees).
	self assert: trees size equals: 1.

	root := trees first.
	self assert: root element equals: (theNodes at: 1).
	self assert: root nodes size equals: 3.
	level1Node1 := root nodes at: 1.
	level1Node2 := root nodes at: 2.
	level1Node3 := root nodes at: 3.
	self assert: level1Node1 element equals: (theNodes at: 2).
	self assert: level1Node2 element equals: (theNodes at: 3).
	self assert: level1Node3 element equals: (theNodes at: 4).
	self assert: level1Node1 nodes size equals: 2.	"The following 2 nodes are actually leaves, but a tree node should be
	 added bellow each of them in order to force distinction of subtrees.
    Those additional nodes should not have any children "
	self assert: level1Node2 nodes size equals: 1.
	self assert: level1Node3 nodes size equals: 1.
	level2Node1 := level1Node1 nodes at: 1.
	self assert: level2Node1 element equals: (theNodes at: 5).
	self assert: level2Node1 nodes size equals: 1.
	self assert: (level2Node1 nodes at: 1) nodes size equals: 0.
	level2Node2 := level1Node1 nodes at: 2.
	self assert: level2Node2 element equals: (theNodes at: 6).
	self assert: level2Node1 nodes size equals: 1.
	self assert: (level2Node1 nodes at: 1) nodes size equals: 0.
	self assert: (level2Node1 nodes at: 1) nodes size equals: 0.
	self assert: (level2Node2 nodes at: 1) nodes size equals: 0.
	self assert: (level1Node3 nodes at: 1) nodes size equals: 0.

	^ root
]

{ #category : #'examples - depth-first search tree' }
GtGradAbstractTreeCreationExamples >> forestDFSCreation [
	<gtExample>
	<return: #Array>
	| theNodes trees root1 root2 |
	theNodes := self createGraphForDepthFirstSearchForest children.

	trees := (GtGradDFSTreeForest from: theNodes separateSubtrees: false) trees.
	self assert: trees size equals: 2.
	self assert: (self getNumberOfNodesOfForest: trees) equals: theNodes size.

	root1 := trees first.
	self assert: root1 element equals: (theNodes at: 1).
	self assert: root1 nodes size equals: 2.
	self assert: (root1 nodes at: 1) element equals: (theNodes at: 2).
	self assert: (root1 nodes at: 2) element equals: (theNodes at: 3).
	self assert: (root1 nodes at: 1) nodes size equals: 2.
	self assert: (root1 nodes at: 2) nodes size equals: 0.
	self assert: ((root1 nodes at: 1) nodes at: 1) element equals: (theNodes at: 4).
	self assert: ((root1 nodes at: 1) nodes at: 2) element equals: (theNodes at: 5).
	self assert: ((root1 nodes at: 1) nodes at: 1) nodes size equals: 0.
	self assert: ((root1 nodes at: 1) nodes at: 2) nodes size equals: 0.

	root2 := trees second.
	self assert: root2 element equals: (theNodes at: 6).
	self assert: root2 nodes size equals: 2.
	self assert: (root2 nodes at: 1) element equals: (theNodes at: 7).
	self assert: (root2 nodes at: 2) element equals: (theNodes at: 8).

	^ trees
]

{ #category : #'private - utilities' }
GtGradAbstractTreeCreationExamples >> getNumberOfLeavesOfForest: theTrees [
	^ theTrees inject: 0 into: [ :numberOfLeaves :aTree |
		numberOfLeaves + (self getNumberOfLeavesOfTree: aTree) ]
]

{ #category : #'private - utilities' }
GtGradAbstractTreeCreationExamples >> getNumberOfLeavesOfTree: theRootNode [
	| queue numberOfLeaves |

	queue := OrderedCollection new.
	queue add: theRootNode.
	numberOfLeaves := 0.

	[ queue isNotEmpty ]
		whileTrue: [ 
			| theCurrentNode |
			theCurrentNode := queue removeAt: 1.
			theCurrentNode nodes isEmpty
				ifTrue: [ 
					numberOfLeaves := numberOfLeaves + 1.
				]
				ifFalse: [ 
					queue addAll: theCurrentNode nodes.	
				]
		].
	^ numberOfLeaves.

]

{ #category : #'private - utilities' }
GtGradAbstractTreeCreationExamples >> getNumberOfNodesOfForest: theTrees [
	^ theTrees inject: 0 into:  [ :numberOfNodes :aTree |
		numberOfNodes + (self getNumberOfNodesOfTree: aTree) ]
]

{ #category : #'private - utilities' }
GtGradAbstractTreeCreationExamples >> getNumberOfNodesOfTree: theRootNode [
	| queue numberOfNodes |
	queue := OrderedCollection new.
	queue add: theRootNode.
	numberOfNodes := 0.
	
	[queue isNotEmpty]
		whileTrue: [ 
			| theCurrentNode |
    		numberOfNodes := numberOfNodes + 1.
			theCurrentNode := queue removeAt: 1.
			queue addAll: theCurrentNode nodes.
		].
	^ numberOfNodes.

]

{ #category : #'examples - depth-first search tree' }
GtGradAbstractTreeCreationExamples >> graphWithCyclesTreeCreationDFS [
	<gtExample>
	<return: #GtGradTreeNode>
	| theNodes trees root level1Node level2Node1 level2Node2 level3Node |
	theNodes := self createGraphForDepthFirstSearchWithCycles children.

	trees := (GtGradDFSTreeForest from: theNodes separateSubtrees: false) trees.
	self assert: trees size equals: 1.
	self assert: (self getNumberOfNodesOfForest: trees) equals: theNodes size.

	root := trees first.
	self assert: root element equals: (theNodes at: 1).
	self assert: root nodes size equals: 1.
	level1Node := root nodes at: 1.
	self assert: level1Node element equals: (theNodes at: 2).
	self assert: level1Node nodes size equals: 2.
	level2Node1 := level1Node nodes at: 1.
	level2Node2 := level1Node nodes at: 2.
	self assert: level2Node1 element equals: (theNodes at: 4).
	self assert: level2Node2 element equals: (theNodes at: 5).
	self assert: level2Node1 nodes size equals: 0.
	self assert: level2Node2 nodes size equals: 1.
	level3Node := level2Node2 nodes at: 1.
	self assert: level3Node nodes size equals: 2.
	self assert: (level3Node nodes at: 1) element equals: (theNodes at: 6).
	self assert: (level3Node nodes at: 2) element equals: (theNodes at: 7).


	^ root
]

{ #category : #'examples - dominance tree' }
GtGradAbstractTreeCreationExamples >> moreComplexDominanceTreeCreation [
	<gtExample>
	<return: #GtGradTreeNode>
	| theNodes trees root level1Node1 level1Node2 level2Node1 level2Node2 level2Node3 level3Node level4Node level5Node |
	theNodes := self createGraphForComplexDominanceTree children.

	trees := (GtGradDominanceTreeForest from: theNodes separateSubtrees: false)
			trees.
	self assert: (self getNumberOfNodesOfForest: trees) equals: theNodes size.
	self assert: trees size equals: 1.

	root := trees first.
	self assert: root element equals: (theNodes at: 1).
	self assert: root nodes size equals: 2.
	level1Node1 := root nodes at: 1.
	level1Node2 := root nodes at: 2.
	self assert: level1Node1 element equals: (theNodes at: 2).
	self assert: level1Node2 element equals: (theNodes at: 3).
	self assert: level1Node1 nodes size equals: 2.
	self assert: level1Node2 nodes size equals: 1.
	level2Node1 := level1Node1 nodes at: 1.
	level2Node2 := level1Node1 nodes at: 2.
	level2Node3 := level1Node2 nodes at: 1.
	self assert: level2Node1 element equals: (theNodes at: 4).
	self assert: level2Node2 element equals: (theNodes at: 9).
	self assert: level2Node3 element equals: (theNodes at: 5).
	self assert: level2Node1 nodes size equals: 0.
	self assert: level2Node2 nodes size equals: 0.
	self assert: level2Node3 nodes size equals: 1.
	level3Node := level2Node3 nodes at: 1.
	self assert: level3Node element equals: (theNodes at: 6).
	self assert: level3Node nodes size equals: 1.
	level4Node := level3Node nodes at: 1.
	self assert: level4Node element equals: (theNodes at: 7).
	self assert: level4Node nodes size equals: 1.
	level5Node := level4Node nodes at: 1.
	self assert: level5Node element equals: (theNodes at: 8).
	self assert: level5Node nodes size equals: 0.

	^ root
]

{ #category : #'examples - dominance tree' }
GtGradAbstractTreeCreationExamples >> simpleDominanceTreeCreation [
	<gtExample>
	<return: #GtGradTreeNode>
	| theNodes trees root level1Node1 level1Node2 level2Node level3Node |
	theNodes := self createGraphForSimpleDominanceTree children.

	trees := (GtGradDominanceTreeForest from: theNodes separateSubtrees: false)
			trees.
	self assert: trees size equals: 1.
	self assert: (self getNumberOfNodesOfForest: trees) equals: theNodes size.
	root := trees first.

	self assert: root element equals: (theNodes at: 1).
	self assert: root nodes size equals: 2.
	level1Node1 := root nodes at: 1.
	level1Node2 := root nodes at: 2.
	self assert: level1Node1 element equals: (theNodes at: 2).
	self assert: level1Node2 element equals: (theNodes at: 3).
	self assert: level1Node1 nodes size equals: 0.
	self assert: level1Node2 nodes size equals: 1.
	level2Node := level1Node2 nodes at: 1.
	self assert: level2Node element equals: (theNodes at: 4).
	self assert: level2Node nodes size equals: 1.
	level3Node := level2Node nodes at: 1.
	self assert: level3Node element equals: (theNodes at: 5).
	self assert: level3Node nodes size equals: 0.

	^ root
]

{ #category : #'examples - depth-first search tree' }
GtGradAbstractTreeCreationExamples >> simpleTreeCreationDFS [
	<gtExample>
	<return: #GtGradTreeNode>
	| theNodes trees root level1Node1 level1Node2 level2Node1 level2Node2 level2Node3 level2Node4 |
	theNodes := self createGraphForDepthFirstSearchTree children.

	trees := (GtGradDFSTreeForest from: theNodes separateSubtrees: false) trees.
	self assert: trees size equals: 1.
	self assert: (self getNumberOfNodesOfForest: trees) equals: theNodes size.

	root := trees first.
	self assert: root element equals: (theNodes at: 1).
	self assert: root nodes size equals: 2.
	level1Node1 := root nodes at: 1.
	level1Node2 := root nodes at: 2.
	self assert: level1Node1 element equals: (theNodes at: 2).
	self assert: level1Node2 element equals: (theNodes at: 3).
	self assert: level1Node1 nodes size equals: 2.
	self assert: level1Node2 nodes size equals: 2.
	level2Node1 := level1Node1 nodes at: 1.
	level2Node2 := level1Node1 nodes at: 2.
	level2Node3 := level1Node2 nodes at: 1.
	level2Node4 := level1Node2 nodes at: 2.
	self assert: level2Node1 element equals: (theNodes at: 4).
	self assert: level2Node2 element equals: (theNodes at: 5).
	self assert: level2Node3 element equals: (theNodes at: 6).
	self assert: level2Node4 element equals: (theNodes at: 7).
	self assert: level2Node1 nodes size equals: 2.
	self assert: level2Node2 nodes size equals: 2.
	self assert: level2Node3 nodes size equals: 4.
	self assert: level2Node4 nodes size equals: 0.
	self assert: (level2Node1 nodes at: 1) element equals: (theNodes at: 8).
	self assert: (level2Node1 nodes at: 2) element equals: (theNodes at: 9).
	self assert: (level2Node2 nodes at: 1) element equals: (theNodes at: 10).
	self assert: (level2Node2 nodes at: 2) element equals: (theNodes at: 11).
	self assert: (level2Node3 nodes at: 1) element equals: (theNodes at: 12).
	self assert: (level2Node3 nodes at: 2) element equals: (theNodes at: 13).
	self assert: (level2Node3 nodes at: 3) element equals: (theNodes at: 14).
	self assert: (level2Node3 nodes at: 4) element equals: (theNodes at: 15).

	^ root
]

{ #category : #'examples - dominance tree' }
GtGradAbstractTreeCreationExamples >> treesWhoseNodesAreConnectedWithOtherTreesNodesCenteredDominance [
	<gtExample>
	<return: #Array>
	| theNodes trees root1 root2 root3 |
	theNodes := self createGraphWhoseNodesAreConnectedWithOtherTrees children.

	trees := (GtGradDominanceCenteredTreeForest
			from: theNodes
			separateSubtrees: false) trees.
	self assert: (self getNumberOfNodesOfForest: trees) equals: theNodes size.
	self assert: trees size equals: 3.

	root1 := trees first.
	root2 := trees second.
	root3 := trees third.

	self assert: root1 element equals: (theNodes at: 1).
	self assert: root1 nodes size equals: 2.
	self assert: (root1 nodes at: 1) element equals: (theNodes at: 2).
	self assert: (root1 nodes at: 2) element equals: (theNodes at: 3).
	self assert: (root1 nodes at: 1) nodes size equals: 1.
	self assert: (root1 nodes at: 2) nodes size equals: 0.
	self assert: ((root1 nodes at: 1) nodes at: 1) nodes size equals: 0.
	self assert: ((root1 nodes at: 1) nodes at: 1) element equals: (theNodes at: 4).

	self assert: root2 element equals: (theNodes at: 5).
	self assert: root2 nodes size equals: 1.
	self assert: (root2 nodes at: 1) element equals: (theNodes at: 6).
	self assert: (root2 nodes at: 1) nodes size equals: 0.

	self assert: root3 element equals: (theNodes at: 7).
	self assert: root3 nodes size equals: 2.
	self assert: (root3 nodes at: 1) element equals: (theNodes at: 8).
	self assert: (root3 nodes at: 1) nodes size equals: 0.
	self assert: (root3 nodes at: 2) element equals: (theNodes at: 9).
	self assert: (root3 nodes at: 2) nodes size equals: 0.

	^ trees
]

{ #category : #'examples - depth-first search tree' }
GtGradAbstractTreeCreationExamples >> treesWhoseNodesAreConnectedWithOtherTreesNodesDFS [
	<gtExample>
	<return: #Array>
	| aParentNode theNodes trees root1 root2 root3 |
	aParentNode := self createGraphWhoseNodesAreConnectedWithOtherTrees.
	theNodes := aParentNode children.

	trees := (GtGradDFSTreeForest from: theNodes separateSubtrees: false) trees.
	self assert: (self getNumberOfNodesOfForest: trees) equals: theNodes size.
	self assert: trees size equals: 3.

	root1 := trees first.
	root2 := trees second.
	root3 := trees third.

	self assert: root1 element equals: (theNodes at: 1).
	self assert: root1 nodes size equals: 2.
	self assert: (root1 nodes at: 1) element equals: (theNodes at: 2).
	self assert: (root1 nodes at: 2) element equals: (theNodes at: 3).
	self assert: (root1 nodes at: 1) nodes size equals: 1.
	self assert: (root1 nodes at: 2) nodes size equals: 0.
	self assert: ((root1 nodes at: 1) nodes at: 1) nodes size equals: 0.
	self assert: ((root1 nodes at: 1) nodes at: 1) element equals: (theNodes at: 4).

	self assert: root2 element equals: (theNodes at: 5).
	self assert: root2 nodes size equals: 1.
	self assert: (root2 nodes at: 1) element equals: (theNodes at: 6).
	self assert: (root2 nodes at: 1) nodes size equals: 0.

	self assert: root3 element equals: (theNodes at: 7).
	self assert: root3 nodes size equals: 2.
	self assert: (root3 nodes at: 1) element equals: (theNodes at: 8).
	self assert: (root3 nodes at: 1) nodes size equals: 0.
	self assert: (root3 nodes at: 2) element equals: (theNodes at: 9).
	self assert: (root3 nodes at: 2) nodes size equals: 0.

	^ trees
]

{ #category : #'examples - dominance tree' }
GtGradAbstractTreeCreationExamples >> treesWhoseNodesAreConnectedWithOtherTreesNodesDominance [
	<gtExample>
	<return: #Array>
	| theNodes trees root1 root2 root3 |
	theNodes := self createGraphWhoseNodesAreConnectedWithOtherTrees children.

	trees := (GtGradDominanceTreeForest from: theNodes separateSubtrees: false)
			trees.
	self assert: (self getNumberOfNodesOfForest: trees) equals: theNodes size.
	self assert: trees size equals: 3.

	root1 := trees first.
	root2 := trees second.
	root3 := trees third.

	self assert: root1 element equals: (theNodes at: 1).
	self assert: root1 nodes size equals: 2.
	self assert: (root1 nodes at: 1) element equals: (theNodes at: 2).
	self assert: (root1 nodes at: 2) element equals: (theNodes at: 3).
	self assert: (root1 nodes at: 1) nodes size equals: 1.
	self assert: (root1 nodes at: 2) nodes size equals: 0.
	self assert: ((root1 nodes at: 1) nodes at: 1) nodes size equals: 0.
	self assert: ((root1 nodes at: 1) nodes at: 1) element equals: (theNodes at: 4).

	self assert: root2 element equals: (theNodes at: 5).
	self assert: root2 nodes size equals: 1.
	self assert: (root2 nodes at: 1) element equals: (theNodes at: 6).
	self assert: (root2 nodes at: 1) nodes size equals: 0.

	self assert: root3 element equals: (theNodes at: 7).
	self assert: root3 nodes size equals: 2.
	self assert: (root3 nodes at: 1) element equals: (theNodes at: 8).
	self assert: (root3 nodes at: 1) nodes size equals: 0.
	self assert: (root3 nodes at: 2) element equals: (theNodes at: 9).
	self assert: (root3 nodes at: 2) nodes size equals: 0.

	^ trees
]
