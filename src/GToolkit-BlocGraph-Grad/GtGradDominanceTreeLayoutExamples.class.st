"
!Dominance tree layout

This layout is a variation of the tree layout which makes sure that a tree node is placed as deep as 
possible.  So, if a node has more than one incoming edge the tree will be formed in such a way that 
its parent is the deepest of all possible  parents.  An example shown below demonstrates this:

${example:name=GtGradVerticalDominanceTreeLayoutExamples>>#dominanceTreeWithMultiplePathsToANodesWith9Nodes|expanded=true|expandedPreview=true|show=gtLiveFor:}$

The node on the fourth level is connected to the root node, as well as the rightmost node on the 
third level. The bottommost node is connected to the middle node on the third level and the only 
node on the fifth level.  In case of the simple tree layout, a spanning tree (to which the layout will be 
applied) is contructed using depth-first search. This procedure would create a tree where the 
mentioned bottomost node would be on the fourth level, with its parent being the middle node on 
the third level..

The following example shows the same graph , but laid out using the horizontal dominance tree:

${example:name=GtGradHorizontalDominanceTreeLayoutExamples>>#dominanceTreeWithMultiplePathsToANodesWith9Nodes|expanded=true|expandedPreview=true|show=gtLiveFor:}$

Other than  different contruction of the tree based on the input graph, there are no other differences 
between this layout and the regular tree layout. Please see its documenation for more details.

"
Class {
	#name : #GtGradDominanceTreeLayoutExamples,
	#superclass : #GtGradAbstractTreeLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #example }
GtGradDominanceTreeLayoutExamples >> constructDominanceTreeWith5Nodes [
	<gtExample>
		
	| theNodes  pairsOfNodes theEdges |
	
	theNodes := self nodes: (1 to: 5).
	theNodes doWithIndex: [ :aNode :index |
		aNode labeled: index asString.
	].
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add:(3->4); add: (4->5); add: (2->5).
	
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.

	^ theNodes -> theEdges

]

{ #category : #example }
GtGradDominanceTreeLayoutExamples >> constructDominanceTreeWithMultiplePathsToANodesWith8Nodes [
	<gtExample>
		
	| theNodes  pairsOfNodes theEdges |
	
	theNodes := self nodes: (1 to: 8).
	theNodes doWithIndex: [ :aNode :index |
		aNode labeled: index asString.	
	].
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add:(3->4); add: (4->5); add: (2->6); add: (2->5);
					 add: (5->6); add: (6->7); add: (7->8); add:(4->8).
	
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.

	^ theNodes -> theEdges

]

{ #category : #example }
GtGradDominanceTreeLayoutExamples >> constructDominanceTreeWithMultiplePathsToANodesWith9Nodes [
	<gtExample>
		
	| theNodes  pairsOfNodes theEdges |
	
	theNodes := self nodes: (1 to: 9).
	theNodes doWithIndex: [ :aNode :index |
		aNode labeled: index asString.	
	].
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add: (2->4); add: (2->7); add: (2->9);
					 add: (3->5); add: (5->6); add: (6->7); add: (7->8); add: (9->8).
	
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.

	^ theNodes -> theEdges

]

{ #category : #'example - instance creation' }
GtGradDominanceTreeLayoutExamples >> constructForest: theNodes [
	^ GtGradDominanceTreeForest from: theNodes separateSubtrees: false
]

{ #category : #'example - instance creation' }
GtGradDominanceTreeLayoutExamples >> constructGraphWithANodeWithSeveralIncomingEdges [
	<gtExample>
		
	| theNodes  pairsOfNodes theEdges |
	
	theNodes := self nodes: (1 to: 6).
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add: (1->4); add: (1->5);
					 add: (2->6); add: (3->6); add: (4->6); add: (5->6).

	
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.
	

	^ theNodes -> theEdges

	
 
]

{ #category : #'example - instance creation' }
GtGradDominanceTreeLayoutExamples >> constructTreeWithNodesWithAndWithoutChildrenOnTheSameLevel [
	<gtExample>
		
	| theNodes  pairsOfNodes theEdges |
	
	theNodes := self nodes: (1 to: 7).
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add:(1->4); add: (2->5); add: (2->6);
	 add: (2->7).
	
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.
	

	^ theNodes -> theEdges

	
 
]

{ #category : #'example - instance creation' }
GtGradDominanceTreeLayoutExamples >> dominanceTreeLayout [
	^ self subclassResponsibility
]

{ #category : #example }
GtGradDominanceTreeLayoutExamples >> dominanceTreeWithMultiplePathsToANodesWith8Nodes [
	^ self subclassResponsibility
]

{ #category : #example }
GtGradDominanceTreeLayoutExamples >> dominanceTreeWithMultiplePathsToANodesWith9Nodes [
	^ self subclassResponsibility
]

{ #category : #example }
GtGradDominanceTreeLayoutExamples >> simpleDominanceTreeWith5Nodes [
	^ self subclassResponsibility
]
