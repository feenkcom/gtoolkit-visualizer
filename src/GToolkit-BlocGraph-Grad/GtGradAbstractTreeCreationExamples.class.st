Class {
	#name : #GtGradAbstractTreeCreationExamples,
	#superclass : #GtGradLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'as yet unclassified' }
GtGradAbstractTreeCreationExamples >> forserDFSCreation [
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

	^ root1
]

{ #category : #'as yet unclassified' }
GtGradAbstractTreeCreationExamples >> graphWithCyclesTreeCreationDFS [
	<gtExample>
	
	| theNodes  pairsOfNodes theEdges root level1Node level2Node1 level2Node2 level3Node|
	
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
	
	root := (GtGradDFSTreeForest from: theNodes separateSubtrees: false) trees first.
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

{ #category : #'as yet unclassified' }
GtGradAbstractTreeCreationExamples >> simpleTreeCreationDFS [
	<gtExample>
	| theNodes pairsOfNodes theEdges root level1Node1 level1Node2
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
	
	root := (GtGradDFSTreeForest from: theNodes separateSubtrees: false) trees first.
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
