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
GtGradHierarchicalTreeLayoutExamples >> eastTree [
	<gtExample>
	| pairsOfNodes theEdges view theNodes aLayout |
	view := self view.
	theNodes := self nodes: (1 to: 7).
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes
		add: 1 -> 2;
		add: 1 -> 3;
		add: 2 -> 4;
		add: 2 -> 5;
		add: 3 -> 6;
		add: 3 -> 7;
		add: 6 -> 2;
		add: 5 -> 3.
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.
	aLayout := GtGradEastHierarchicalTreeLayout new.
	view addChildren: theNodes.
	view layout: aLayout.
	view forceLayout.
	self
		assert: (aLayout layout isKindOf: GtGradHorizontalDominanceTreeLayout).
	self assert: aLayout layout reverse.
	self
		assert: aLayout layout nodeDistance
		equals: aLayout nodesDistance.
	self
		assert: aLayout layout levelDistance
		equals: aLayout levelDistance.
	self
		assert: aLayout layout treesDistance
		equals: aLayout componentsDistance.
	self
		assert: (aLayout layout nodesAlignment isMemberOf: GtGradTreeNodesCenterAlignment).
	^ view
]

{ #category : #example }
GtGradHierarchicalTreeLayoutExamples >> northTree [
	<gtExample>
		
	|  pairsOfNodes theEdges view theNodes aLayout |
	
	view := self view.
	theNodes := self nodes: (1 to: 7).
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes
		add: 1 -> 2;
		add: 1 -> 3;
		add: 2 -> 4;
		add: 2 -> 5;
		add: 3 -> 6;
		add: 3 -> 7;
		add: 6 -> 2;
		add: 5 -> 3.
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.
	aLayout := GtGradNorthHierarchicalTreeLayout new.
	view addChildren: theNodes.
	view layout: aLayout.
	view forceLayout.
	
	self
		assert: (aLayout layout isKindOf: GtGradVerticalDominanceTreeLayout).
	self assert: aLayout layout reverse not.
	self
		assert: aLayout layout nodeDistance
		equals: aLayout nodesDistance.
	self
		assert: aLayout layout levelDistance
		equals: aLayout levelDistance.
	self
		assert: aLayout layout treesDistance
		equals: aLayout componentsDistance.
	self
		assert: (aLayout layout nodesAlignment isMemberOf: GtGradTreeNodesCenterAlignment).
	
	^ view
]

{ #category : #example }
GtGradHierarchicalTreeLayoutExamples >> southTree [
	<gtExample>
		
	|  pairsOfNodes theEdges view theNodes aLayout |
	
	view := self view.
	theNodes := self nodes: (1 to: 7).
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes
		add: 1 -> 2;
		add: 1 -> 3;
		add: 2 -> 4;
		add: 2 -> 5;
		add: 3 -> 6;
		add: 3 -> 7;
		add: 6 -> 2;
		add: 5 -> 3.
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.
	aLayout := GtGradSouthHierarchicalTreeLayout new.
	view addChildren: theNodes.
	view layout: aLayout.
	view forceLayout.
	
	self
		assert: (aLayout layout isKindOf: GtGradVerticalDominanceTreeLayout).
	self assert: aLayout layout reverse.
	self
		assert: aLayout layout nodeDistance
		equals: aLayout nodesDistance.
	self
		assert: aLayout layout levelDistance
		equals: aLayout levelDistance.
	self
		assert: aLayout layout treesDistance
		equals: aLayout componentsDistance.
	self
		assert: (aLayout layout nodesAlignment isMemberOf: GtGradTreeNodesCenterAlignment).
	^ view
]

{ #category : #example }
GtGradHierarchicalTreeLayoutExamples >> westTree [
	<gtExample>
		
	|  pairsOfNodes theEdges view theNodes aLayout |
	
	view := self view.
	theNodes := self nodes: (1 to: 7).
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes
		add: 1 -> 2;
		add: 1 -> 3;
		add: 2 -> 4;
		add: 2 -> 5;
		add: 3 -> 6;
		add: 3 -> 7;
		add: 6 -> 2;
		add: 5 -> 3.
	theEdges := self connectPairsOfNodes: theNodes pairs: pairsOfNodes.
	aLayout := GtGradWestHierarchicalTreeLayout new.
	view addChildren: theNodes.
	view layout: aLayout.
	view forceLayout.
	
	self
		assert: (aLayout layout isKindOf: GtGradHorizontalDominanceTreeLayout).
	self assert: aLayout layout reverse not.
	self
		assert: aLayout layout nodeDistance
		equals: aLayout nodesDistance.
	self
		assert: aLayout layout levelDistance
		equals: aLayout levelDistance.
	self
		assert: aLayout layout treesDistance
		equals: aLayout componentsDistance.
	self
		assert: (aLayout layout nodesAlignment isMemberOf: GtGradTreeNodesCenterAlignment).
	
	^ view
]
