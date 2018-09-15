Class {
	#name : #GtGradDominanceTreeLayoutExamples,
	#superclass : #GtGradLayoutExamples,
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
