"
!Centered dominance tree layout

This layout is a variation of the dominance  tree layout which not only makes sure that a tree node is placed as deep as 
possible, but also that it is centered.  Please see dominance tree documentation to learn more about the depth aspect of the layout.

A node being centered means that, if it has multiple incoming edges starting at nodes at the same level, it will be placed under the middle one. An example is shown below:

${example:name=GtGradVerticalDominanceCenteredTreeLayoutExamples>>#moreComplexGraphWithANodeWithSeveralIncomingEdges|expanded=true|expandedPreview=true|show=gtLiveFor:}$

All nodes on the second level are conneceted to the rightmost node on the third level. A simple depth-first search would form a tree where this node would be placed under the leftmost node on the second level. However, it can be seen that this layout placed it under the second node on the second level. The same can be seen in case of the bottommost node, whose possible parent sinclude all nodes on the second to last level. 

The following example shows the same graph , but laid out using the horizontal centered dominance tree:

${example:name=GtGradHorizontalDominanceCenteredTreeLayoutExamples>>#moreComplexGraphWithANodeWithSeveralIncomingEdges|expanded=true|expandedPreview=true|show=gtLiveFor:}$

"
Class {
	#name : #GtGradDominanceCenteredTreeLayoutExamples,
	#superclass : #GtGradAbstractTreeLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'example - instance creation' }
GtGradDominanceCenteredTreeLayoutExamples >> construcTreeWithEdgesWhoseSoucesAreOnDifferentLevels [
	<gtExample>
		
	| theNodes  pairsOfNodes theEdges |
	
	theNodes := self nodes: (1 to: 6).
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add: (1->4);
					 add: (2->5); add: (5->6); add: (3->6).
					 
	
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.
	

	^ theNodes -> theEdges


]

{ #category : #'example - instance creation' }
GtGradDominanceCenteredTreeLayoutExamples >> constructForest: theNodes [
	^ GtGradDominanceCenteredTreeForest from: theNodes separateSubtrees: false
]

{ #category : #'example - instance creation' }
GtGradDominanceCenteredTreeLayoutExamples >> constructGraphWithANodeWithSeveralIncomingEdges [
	<gtExample>
		
	| theNodes  pairsOfNodes theEdges |
	
	theNodes := self nodes: (1 to: 5).
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add: (1->4);
					 add: (2->5); add: (3->5); add: (4->5).

	
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.
	

	^ theNodes -> theEdges

	
 
]

{ #category : #'example - instance creation' }
GtGradDominanceCenteredTreeLayoutExamples >> constructMoreComplexGraphWithANodeWithSeveralIncomingEdges [
	<gtExample>
		
	| theNodes  pairsOfNodes theEdges |
	
	theNodes := self nodes: (1 to: 11).
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add: (1->4); add: (1->5);
					 add: (2->6); add: (3->6); add: (4->6); add: (5->6);
					 add: (6->7); add: (6->8); add: (2->10); add: (10->11);
					 add: (11->9); add: (7->9); add: (8->9).
					 
	
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.
	

	^ theNodes -> theEdges


]
