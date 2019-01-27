Class {
	#name : #GtGradHierarchicalTreeLayoutExamples,
	#superclass : #GtGradLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #example }
GtGradHierarchicalTreeLayoutExamples >> constructGraphWithCycles [		
	| theNodes  pairsOfNodes theEdges |
	
	theNodes := self nodes: (1 to: 12).
	theNodes doWithIndex: [ :node :index |
			node labeled: (index asString).
		].
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add:(2->4); add: (2->5); add: (3->6); add: (3->7);
	add: (6->2); add: (5->3).
	
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.

	^ theNodes -> theEdges

	
 
]

{ #category : #example }
GtGradHierarchicalTreeLayoutExamples >> graphWithCycles [
	<gtExample>
		
	|  view theNodes aLayout |
	
	view := self view.
	theNodes := self constructGraphWithCycles key.
	aLayout := GtGradNorthHierarchicalTreeLayout new.
	view addChildren: theNodes.
	view layout: aLayout.
	view forceLayout.
	
	^ view
]
