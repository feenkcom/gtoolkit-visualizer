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
