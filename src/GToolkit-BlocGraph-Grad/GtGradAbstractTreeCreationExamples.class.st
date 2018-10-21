Class {
	#name : #GtGradAbstractTreeCreationExamples,
	#superclass : #GtGradLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #example }
GtGradAbstractTreeCreationExamples >> centeredDominanceTreesCreation [
	<gtExample>
	| theNodes pairsOfNodes theEdges trees root level1Node1 level1Node2 level1Node3 level1Node4
	  level2Node1 level2Node2 level3Node1 level3Node2 level3Node3|

	theNodes := self nodes: (1 to: 11).
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add: (1->4); add: (1->5);
					 add: (2->6); add: (3->6); add: (4->6); add: (5->6);
					 add: (6->7); add: (6->8); add: (2->10); add: (10->11);
					 add: (11->9); add: (7->9); add: (8->9).
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.

	self assert: ((theNodes at: 1) graph) nodesAlongOutgoingEdgesCount equals: 4.
	self assert: ((theNodes at: 1) graph) nodesAlongIncomingEdgesCount equals: 0.
	self assert: ((theNodes at: 2) graph) nodesAlongOutgoingEdgesCount equals: 2.
	self assert: ((theNodes at: 2) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 3) graph) nodesAlongOutgoingEdgesCount equals: 1.
	self assert: ((theNodes at: 3) graph) nodesAlongIncomingEdgesCount equals: 1.	
	self assert: ((theNodes at: 4) graph) nodesAlongOutgoingEdgesCount equals: 1.
	self assert: ((theNodes at: 4) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 5) graph) nodesAlongOutgoingEdgesCount equals: 1.
	self assert: ((theNodes at: 5) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 6) graph) nodesAlongOutgoingEdgesCount equals: 2.
	self assert: ((theNodes at: 6) graph) nodesAlongIncomingEdgesCount equals: 4.
	self assert: ((theNodes at: 7) graph) nodesAlongOutgoingEdgesCount equals: 1.
	self assert: ((theNodes at: 7) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 8) graph) nodesAlongOutgoingEdgesCount equals: 1.
	self assert: ((theNodes at: 8) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 9) graph) nodesAlongOutgoingEdgesCount equals: 0.
	self assert: ((theNodes at: 9) graph) nodesAlongIncomingEdgesCount equals: 3.
	self assert: ((theNodes at: 10) graph) nodesAlongOutgoingEdgesCount equals: 1.
	self assert: ((theNodes at: 10) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 11) graph) nodesAlongOutgoingEdgesCount equals: 1.
	self assert: ((theNodes at: 11) graph) nodesAlongIncomingEdgesCount equals: 1.

	self assert: theEdges size equals: 15.	
	trees := (GtGradDominanceCenteredTreeForest from: theNodes separateSubtrees: true) trees.
	self assert: trees size equals: 1.
	self assert: (self getNumberOfNodesOfForest: trees) equals: (theNodes size + (self getNumberOfLeavesOfForest: trees)).
	
	root := trees first.
	
	self assert: root element equals:(theNodes at: 1).
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
	
	
	^	root

]

{ #category : #example }
GtGradAbstractTreeCreationExamples >> distinctDominanceSubtrees [
	<gtExample>
	| theNodes pairsOfNodes theEdges trees root level1Node1 level1Node2 level1Node3
	  level2Node1 level2Node2 |

	theNodes := self nodes: (1 to: 6).
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add:(1->4); add: (2->5); add: (2->6); add:(3->5).
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.

	self assert: ((theNodes at: 1) graph) nodesAlongOutgoingEdgesCount equals: 3.
	self assert: ((theNodes at: 1) graph) nodesAlongIncomingEdgesCount equals: 0.
	self assert: ((theNodes at: 2) graph) nodesAlongOutgoingEdgesCount equals: 2.
	self assert: ((theNodes at: 2) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 3) graph) nodesAlongOutgoingEdgesCount equals: 1.
	self assert: ((theNodes at: 3) graph) nodesAlongIncomingEdgesCount equals: 1.	
	self assert: ((theNodes at: 4) graph) nodesAlongOutgoingEdgesCount equals: 0.
	self assert: ((theNodes at: 4) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 5) graph) nodesAlongOutgoingEdgesCount equals: 0.
	self assert: ((theNodes at: 5) graph) nodesAlongIncomingEdgesCount equals: 2.
	self assert: ((theNodes at: 6) graph) nodesAlongOutgoingEdgesCount equals: 0.
	self assert: ((theNodes at: 6) graph) nodesAlongIncomingEdgesCount equals: 1.


	self assert: theEdges size equals: 6.	
	trees := (GtGradDominanceTreeForest from: theNodes separateSubtrees: true) trees.
	self assert: (self getNumberOfNodesOfForest: trees) equals: (theNodes size + (self getNumberOfLeavesOfForest: trees)).
	self assert: trees size equals: 1.
	
	root := trees first.
	self assert: root element equals:(theNodes at: 1).
	self assert: root nodes size equals: 3.
	level1Node1 := root nodes at: 1.
	level1Node2 := root nodes at: 2.
	level1Node3 := root nodes at: 3.
	self assert: level1Node1 element equals: (theNodes at: 2).
	self assert: level1Node2 element equals: (theNodes at: 3).
	self assert: level1Node3 element equals: (theNodes at: 4).
	self assert: level1Node1 nodes size equals: 2.
	"The following 2 nodes are actually leaves, but a tree node should be
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
	
	^	root

	
	
				

]

{ #category : #example }
GtGradAbstractTreeCreationExamples >> distinctSubtreesDFS [
	<gtExample>
	| theNodes pairsOfNodes theEdges trees root level1Node1 level1Node2 level1Node3
	  level2Node1 level2Node2 |

	theNodes := self nodes: (1 to: 6).
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add:(1->4); add: (2->5); add: (2->6).
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.

	self assert: ((theNodes at: 1) graph) nodesAlongOutgoingEdgesCount equals: 3.
	self assert: ((theNodes at: 1) graph) nodesAlongIncomingEdgesCount equals: 0.
	self assert: ((theNodes at: 2) graph) nodesAlongOutgoingEdgesCount equals: 2.
	self assert: ((theNodes at: 2) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 3) graph) nodesAlongOutgoingEdgesCount equals: 0.
	self assert: ((theNodes at: 3) graph) nodesAlongIncomingEdgesCount equals: 1.	
	self assert: ((theNodes at: 4) graph) nodesAlongOutgoingEdgesCount equals: 0.
	self assert: ((theNodes at: 4) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 5) graph) nodesAlongOutgoingEdgesCount equals: 0.
	self assert: ((theNodes at: 5) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 6) graph) nodesAlongOutgoingEdgesCount equals: 0.
	self assert: ((theNodes at: 6) graph) nodesAlongIncomingEdgesCount equals: 1.


	self assert: theEdges size equals: 5.	
	trees := (GtGradDFSTreeForest from: theNodes separateSubtrees: true) trees.
	self assert: (self getNumberOfNodesOfForest: trees) equals: (theNodes size + (self getNumberOfLeavesOfForest: trees)).
	self assert: trees size equals: 1.
	
	root := trees first.
	self assert: root element equals:(theNodes at: 1).
	self assert: root nodes size equals: 3.
	level1Node1 := root nodes at: 1.
	level1Node2 := root nodes at: 2.
	level1Node3 := root nodes at: 3.
	self assert: level1Node1 element equals: (theNodes at: 2).
	self assert: level1Node2 element equals: (theNodes at: 3).
	self assert: level1Node3 element equals: (theNodes at: 4).
	self assert: level1Node1 nodes size equals: 2.
	"The following 2 nodes are actually leaves, but a tree node should be
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
	
	^	root

	
	
				

]

{ #category : #example }
GtGradAbstractTreeCreationExamples >> forestDFSCreation [
	<gtExample>
	
	| theNodes  pairsOfNodes theEdges trees root1 root2 |
	
	theNodes := self nodes: (1 to: 8).
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add: (2->4); add: (2->5);
					 add: (6->7); add: (6->8).
	
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.
	
	self assert: theEdges size equals: 6.	
	self assert: ((theNodes at: 1) graph) nodesAlongOutgoingEdgesCount equals: 2.
	self assert: ((theNodes at: 1) graph) nodesAlongIncomingEdgesCount equals: 0.
	self assert: ((theNodes at: 2) graph) nodesAlongOutgoingEdgesCount equals: 2.
	self assert: ((theNodes at: 2) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 3) graph) nodesAlongOutgoingEdgesCount equals: 0.
	self assert: ((theNodes at: 3) graph) nodesAlongIncomingEdgesCount equals: 1.	
	self assert: ((theNodes at: 4) graph) nodesAlongOutgoingEdgesCount equals: 0.
	self assert: ((theNodes at: 4) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 5) graph) nodesAlongOutgoingEdgesCount equals: 0.
	self assert: ((theNodes at: 5) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 6) graph) nodesAlongOutgoingEdgesCount equals: 2.
	self assert: ((theNodes at: 6) graph) nodesAlongIncomingEdgesCount equals: 0.
	self assert: ((theNodes at: 7) graph) nodesAlongOutgoingEdgesCount equals: 0.
	self assert: ((theNodes at: 7) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 8) graph) nodesAlongOutgoingEdgesCount equals: 0.
	self assert: ((theNodes at: 8) graph) nodesAlongIncomingEdgesCount equals: 1.
	

	trees := (GtGradDFSTreeForest from: theNodes separateSubtrees: false) trees.
	self assert: trees size equals: 2.
	self assert: (self getNumberOfNodesOfForest: trees) equals: (theNodes size).
	
	root1 := trees first.
	self assert: root1 element equals:(theNodes at: 1).
	self assert: root1 nodes size equals: 2.
	self assert: (root1 nodes at: 1) element equals: (theNodes at: 2).
	self assert: (root1 nodes at: 2) element equals: (theNodes at: 3).
	self assert: ((root1 nodes at: 1) nodes size) equals: 2.
	self assert: ((root1 nodes at: 2) nodes size) equals: 0.
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

{ #category : #example }
GtGradAbstractTreeCreationExamples >> getNumberOfLeavesOfForest: aForest [
	| numberOfLeaves |
	numberOfLeaves := 0.
	aForest do: [ :aTree |
		numberOfLeaves := numberOfLeaves + (self getNumberOfLeavesOfTree: aTree)
	].

	^ numberOfLeaves.

]

{ #category : #example }
GtGradAbstractTreeCreationExamples >> getNumberOfLeavesOfTree: theRootNode [
	| queue numberOfLeaves |
	queue := OrderedCollection new.
	queue add: theRootNode.
	numberOfLeaves := 0.
	
	[queue isNotEmpty]
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

{ #category : #example }
GtGradAbstractTreeCreationExamples >> getNumberOfNodesOfForest: aForest [
	| numberOfNodes |
	numberOfNodes := 0.
	aForest do: [ :aTree |
		numberOfNodes := numberOfNodes + (self getNumberOfNodesOfTree: aTree)
	].

	^ numberOfNodes.

]

{ #category : #example }
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

{ #category : #example }
GtGradAbstractTreeCreationExamples >> graphWithCyclesTreeCreationDFS [
	<gtExample>
	
	| theNodes  pairsOfNodes theEdges trees root level1Node level2Node1
	  level2Node2 level3Node |
	
	theNodes := self nodes: (1 to: 7).
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add:(2->4); add: (2->5); add: (3->6); add: (3->7);
	add: (6->2); add: (5->3).
	
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.	
	
	self assert: theEdges size equals: 8.
	
	self assert: ((theNodes at: 1) graph) nodesAlongOutgoingEdgesCount equals: 2.
	self assert: ((theNodes at: 1) graph) nodesAlongIncomingEdgesCount equals: 0.
	self assert: ((theNodes at: 2) graph) nodesAlongOutgoingEdgesCount equals: 2.
	self assert: ((theNodes at: 2) graph) nodesAlongIncomingEdgesCount equals: 2.
	self assert: ((theNodes at: 3) graph) nodesAlongOutgoingEdgesCount equals: 2. 
	self assert: ((theNodes at: 3) graph) nodesAlongIncomingEdgesCount equals: 2. 
	self assert: ((theNodes at: 4) graph) nodesAlongOutgoingEdgesCount equals: 0.
	self assert: ((theNodes at: 4) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 5) graph) nodesAlongOutgoingEdgesCount equals: 1.
	self assert: ((theNodes at: 5) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 6) graph) nodesAlongOutgoingEdgesCount equals: 1.
	self assert: ((theNodes at: 6) graph) nodesAlongIncomingEdgesCount equals: 1.
	
	trees := (GtGradDFSTreeForest from: theNodes separateSubtrees: false) trees.
	self assert: trees size equals: 1.
	self assert: (self getNumberOfNodesOfForest: trees) equals: (theNodes size).
	
	root := trees first.
	self assert: root element equals:(theNodes at: 1).
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

{ #category : #example }
GtGradAbstractTreeCreationExamples >> moreComplexDominanceTreeCreation [
	<gtExample>
	| theNodes pairsOfNodes theEdges trees root level1Node1 level1Node2
	level2Node1 level2Node2 level2Node3 level3Node level4Node level5Node |

	pairsOfNodes := OrderedCollection new.
	theNodes := self nodes: (1 to: 9).
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add: (2->4); add: (2->7); add: (2->9);
					 add: (3->5); add: (5->6); add: (6->7); add: (7->8); add: (9->8).
	
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.
	
	self assert: ((theNodes at: 1) graph) nodesAlongOutgoingEdgesCount equals: 2.
	self assert: ((theNodes at: 1) graph) nodesAlongIncomingEdgesCount equals: 0.
	self assert: ((theNodes at: 2) graph) nodesAlongOutgoingEdgesCount equals: 3.
	self assert: ((theNodes at: 2) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 7) graph) nodesAlongOutgoingEdgesCount equals: 1. 
	self assert: ((theNodes at: 7) graph) nodesAlongIncomingEdgesCount equals: 2. 
	self assert: ((theNodes at: 8) graph) nodesAlongOutgoingEdgesCount equals: 0.
	self assert: ((theNodes at: 8) graph) nodesAlongIncomingEdgesCount equals: 2.
	self assert: ((theNodes at: 9) graph) nodesAlongOutgoingEdgesCount equals: 1.
	self assert: ((theNodes at: 9) graph) nodesAlongIncomingEdgesCount equals: 1.	

	self assert: theEdges size equals: 10.
	
	trees := (GtGradDominanceTreeForest from: theNodes separateSubtrees: false) trees.
	self assert: (self getNumberOfNodesOfForest: trees) equals: (theNodes size).	
	self assert: trees size equals: 1.
	
	root := trees first.
	self assert: root element equals:(theNodes at: 1).
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

{ #category : #example }
GtGradAbstractTreeCreationExamples >> simpleDominanceTreeCreation [
	<gtExample>
	| theNodes pairsOfNodes theEdges trees root level1Node1 level1Node2 level2Node level3Node |

	theNodes := self nodes: (1 to: 5).
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add:(3->4); add: (4->5); add: (2->5).
	
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.
	
	
	self assert: ((theNodes at: 1) graph) nodesAlongOutgoingEdgesCount equals: 2.
	self assert: ((theNodes at: 1) graph) nodesAlongIncomingEdgesCount equals: 0.
	self assert: ((theNodes at: 2) graph) nodesAlongOutgoingEdgesCount equals: 1.
	self assert: ((theNodes at: 2) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 3) graph) nodesAlongOutgoingEdgesCount equals: 1. 
	self assert: ((theNodes at: 3) graph) nodesAlongIncomingEdgesCount equals: 1. 
	self assert: ((theNodes at: 4) graph) nodesAlongOutgoingEdgesCount equals: 1.
	self assert: ((theNodes at: 4) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 5) graph) nodesAlongOutgoingEdgesCount equals: 0.
	self assert: ((theNodes at: 5) graph) nodesAlongIncomingEdgesCount equals: 2.	

	self assert: theEdges size equals: 5.
	
	trees := (GtGradDominanceTreeForest from: theNodes separateSubtrees: false) trees.
	self assert: trees size equals: 1.
	self assert: (self getNumberOfNodesOfForest: trees) equals: (theNodes size).
	root := trees first.
	
	self assert: root element equals:(theNodes at: 1).
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
	
	^ root.
]

{ #category : #example }
GtGradAbstractTreeCreationExamples >> simpleTreeCreationDFS [
	<gtExample>
	| theNodes pairsOfNodes theEdges trees root level1Node1 level1Node2
	level2Node1 level2Node2 level2Node3 level2Node4 |

	theNodes := self nodes: (1 to: 15).
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add:(2->4); add: (2->5); add: (3->6); add: (3->7);
	add: (4->8); add: (4->9); add: (5->10); add: (5->11); add: (6->12); add: (6->13); add: (6->14); 	add: (6->15).
	
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.
	
	self assert: ((theNodes at: 1) graph) nodesAlongOutgoingEdgesCount equals: 2.
	self assert: ((theNodes at: 1) graph) nodesAlongIncomingEdgesCount equals: 0.
	self assert: ((theNodes at: 2) graph) nodesAlongOutgoingEdgesCount equals: 2.
	self assert: ((theNodes at: 2) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 6) graph) nodesAlongOutgoingEdgesCount equals: 4. 
	self assert: ((theNodes at: 6) graph) nodesAlongIncomingEdgesCount equals: 1. 
	self assert: ((theNodes at: 15) graph) nodesAlongOutgoingEdgesCount equals: 0.
	self assert: ((theNodes at: 15) graph) nodesAlongIncomingEdgesCount equals: 1.

	self assert: theEdges size equals: 14.
	
	trees := (GtGradDFSTreeForest from: theNodes separateSubtrees: false) trees.
	self assert: trees size equals: 1.
	self assert: (self getNumberOfNodesOfForest: trees) equals: (theNodes size).		
	
	root := trees first.
	self assert: root element equals:(theNodes at: 1).
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

{ #category : #example }
GtGradAbstractTreeCreationExamples >> treesWhoseNodesAreConnectedWithOtherTreesNodesCenteredDominance [
	<gtExample>
	| theNodes pairsOfNodes theEdges trees root1 root2 root3 |

	theNodes := self nodes: (1 to: 9).
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add:(2->4); add: (5->6); add: (7->8);
					 add: (7->9); add: (6->4); add: (8->4); add: (9->4).
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.

	self assert: ((theNodes at: 1) graph) nodesAlongOutgoingEdgesCount equals: 2.
	self assert: ((theNodes at: 1) graph) nodesAlongIncomingEdgesCount equals: 0.
	self assert: ((theNodes at: 2) graph) nodesAlongOutgoingEdgesCount equals: 1.
	self assert: ((theNodes at: 2) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 3) graph) nodesAlongOutgoingEdgesCount equals: 0.
	self assert: ((theNodes at: 3) graph) nodesAlongIncomingEdgesCount equals: 1.	
	self assert: ((theNodes at: 4) graph) nodesAlongOutgoingEdgesCount equals: 0.
	self assert: ((theNodes at: 4) graph) nodesAlongIncomingEdgesCount equals: 4.
	self assert: ((theNodes at: 5) graph) nodesAlongOutgoingEdgesCount equals: 1.
	self assert: ((theNodes at: 5) graph) nodesAlongIncomingEdgesCount equals: 0.
	self assert: ((theNodes at: 6) graph) nodesAlongOutgoingEdgesCount equals: 1.
	self assert: ((theNodes at: 6) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 7) graph) nodesAlongIncomingEdgesCount equals: 0.
	self assert: ((theNodes at: 7) graph) nodesAlongOutgoingEdgesCount equals: 2.
	self assert: ((theNodes at: 8) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 8) graph) nodesAlongOutgoingEdgesCount equals: 1.
	self assert: ((theNodes at: 9) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 9) graph) nodesAlongOutgoingEdgesCount equals: 1.


	self assert: theEdges size equals: 9.	
	trees := (GtGradDominanceCenteredTreeForest from: theNodes separateSubtrees: false) trees.
	self assert: (self getNumberOfNodesOfForest: trees) equals: (theNodes size).
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

	^	trees				

]

{ #category : #example }
GtGradAbstractTreeCreationExamples >> treesWhoseNodesAreConnectedWithOtherTreesNodesDFS [
	<gtExample>
	| theNodes pairsOfNodes theEdges trees root1 root2 root3 |

	theNodes := self nodes: (1 to: 9).
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add:(2->4); add: (5->6); add: (7->8);
					 add: (7->9); add: (6->4); add: (8->4); add: (9->4).
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.

	self assert: ((theNodes at: 1) graph) nodesAlongOutgoingEdgesCount equals: 2.
	self assert: ((theNodes at: 1) graph) nodesAlongIncomingEdgesCount equals: 0.
	self assert: ((theNodes at: 2) graph) nodesAlongOutgoingEdgesCount equals: 1.
	self assert: ((theNodes at: 2) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 3) graph) nodesAlongOutgoingEdgesCount equals: 0.
	self assert: ((theNodes at: 3) graph) nodesAlongIncomingEdgesCount equals: 1.	
	self assert: ((theNodes at: 4) graph) nodesAlongOutgoingEdgesCount equals: 0.
	self assert: ((theNodes at: 4) graph) nodesAlongIncomingEdgesCount equals: 4.
	self assert: ((theNodes at: 5) graph) nodesAlongOutgoingEdgesCount equals: 1.
	self assert: ((theNodes at: 5) graph) nodesAlongIncomingEdgesCount equals: 0.
	self assert: ((theNodes at: 6) graph) nodesAlongOutgoingEdgesCount equals: 1.
	self assert: ((theNodes at: 6) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 7) graph) nodesAlongIncomingEdgesCount equals: 0.
	self assert: ((theNodes at: 7) graph) nodesAlongOutgoingEdgesCount equals: 2.
	self assert: ((theNodes at: 8) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 8) graph) nodesAlongOutgoingEdgesCount equals: 1.
	self assert: ((theNodes at: 9) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 9) graph) nodesAlongOutgoingEdgesCount equals: 1.


	self assert: theEdges size equals: 9.	
	trees := (GtGradDFSTreeForest from: theNodes separateSubtrees: false) trees.
	self assert: (self getNumberOfNodesOfForest: trees) equals: (theNodes size).
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

	^	trees				

]

{ #category : #example }
GtGradAbstractTreeCreationExamples >> treesWhoseNodesAreConnectedWithOtherTreesNodesDominance [
	<gtExample>
	| theNodes pairsOfNodes theEdges trees root1 root2 root3 |

	theNodes := self nodes: (1 to: 9).
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add:(2->4); add: (5->6); add: (7->8);
					 add: (7->9); add: (6->4); add: (8->4); add: (9->4).
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.

	self assert: ((theNodes at: 1) graph) nodesAlongOutgoingEdgesCount equals: 2.
	self assert: ((theNodes at: 1) graph) nodesAlongIncomingEdgesCount equals: 0.
	self assert: ((theNodes at: 2) graph) nodesAlongOutgoingEdgesCount equals: 1.
	self assert: ((theNodes at: 2) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 3) graph) nodesAlongOutgoingEdgesCount equals: 0.
	self assert: ((theNodes at: 3) graph) nodesAlongIncomingEdgesCount equals: 1.	
	self assert: ((theNodes at: 4) graph) nodesAlongOutgoingEdgesCount equals: 0.
	self assert: ((theNodes at: 4) graph) nodesAlongIncomingEdgesCount equals: 4.
	self assert: ((theNodes at: 5) graph) nodesAlongOutgoingEdgesCount equals: 1.
	self assert: ((theNodes at: 5) graph) nodesAlongIncomingEdgesCount equals: 0.
	self assert: ((theNodes at: 6) graph) nodesAlongOutgoingEdgesCount equals: 1.
	self assert: ((theNodes at: 6) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 7) graph) nodesAlongIncomingEdgesCount equals: 0.
	self assert: ((theNodes at: 7) graph) nodesAlongOutgoingEdgesCount equals: 2.
	self assert: ((theNodes at: 8) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 8) graph) nodesAlongOutgoingEdgesCount equals: 1.
	self assert: ((theNodes at: 9) graph) nodesAlongIncomingEdgesCount equals: 1.
	self assert: ((theNodes at: 9) graph) nodesAlongOutgoingEdgesCount equals: 1.


	self assert: theEdges size equals: 9.	
	trees := (GtGradDominanceTreeForest from: theNodes separateSubtrees: false) trees.
	self assert: (self getNumberOfNodesOfForest: trees) equals: (theNodes size).
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

	^	trees				

]
