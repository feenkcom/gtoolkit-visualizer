Class {
	#name : #GtGradDominanceCenteredTreeLayoutExamples,
	#superclass : #GtGradAbstractTreeLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

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
					 add: (2->6); add: (3->6); add: (5->6); add: (4->7);
					 add: (5->8); add: (6->10); add: (6->9); add: (7->9);
					 add: (8->11); add: (10->11); add: (9->11).

	
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.
	

	^ theNodes -> theEdges


]
