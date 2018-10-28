Class {
	#name : #GtGradHorizontalDominanceTreeLayoutExamples,
	#superclass : #GtGradDominanceTreeLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #example }
GtGradHorizontalDominanceTreeLayoutExamples >> distinctSubtrees [
	<gtExample>
		
	| view theNodes aTreeLayout|
	
	view := self view.
	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout separateSubtrees: true.
	theNodes := self constructTreeWithNodesWithAndWithoutChildrenOnTheSameLevel key.
	view addChildren: theNodes.
	view layout: aTreeLayout. 
	view forceLayout. 

	self checkPositionsOfTreesAndNodes:	theNodes layout: aTreeLayout.

	^ view
]

{ #category : #'example - instance creation' }
GtGradHorizontalDominanceTreeLayoutExamples >> dominanceTreeLayout [
	<gtExample>
	|  aTreeLayout |

	aTreeLayout := GtGradHorizontalDominanceTreeLayout new.
	self assert: aTreeLayout levelDistance equals: 10.
	self assert: aTreeLayout nodeDistance equals: 1.

	^ aTreeLayout
]

{ #category : #example }
GtGradHorizontalDominanceTreeLayoutExamples >> dominanceTreeWithMultiplePathsToANodesWith8Nodes [
	<gtExample>
	| view theNodes aTreeLayout |
	
	view := self view.
	theNodes := self constructDominanceTreeWithMultiplePathsToANodesWith8Nodes key. 
	view addChildren: theNodes. 
	aTreeLayout := self dominanceTreeLayout.
	view layout: aTreeLayout.
	view forceLayout.
	
	self checkPositionsOfTreesAndNodes:	theNodes layout: aTreeLayout.
		
	^ view

]

{ #category : #example }
GtGradHorizontalDominanceTreeLayoutExamples >> dominanceTreeWithMultiplePathsToANodesWith9Nodes [
	<gtExample>
	| view theNodes aTreeLayout |
	
	view := self view.
	theNodes := self constructDominanceTreeWithMultiplePathsToANodesWith9Nodes key. 
	view addChildren: theNodes.
	aTreeLayout := self dominanceTreeLayout.
	view layout: aTreeLayout.
	view forceLayout.
	
	self checkPositionsOfTreesAndNodes:	theNodes layout: aTreeLayout.
		
	^ view

]

{ #category : #accessing }
GtGradHorizontalDominanceTreeLayoutExamples >> getNodeLevelConstantAxisDimension: aTreeNode [
	^ aTreeNode element measuredBounds extent x.
	
]

{ #category : #accessing }
GtGradHorizontalDominanceTreeLayoutExamples >> getNodeLevelConstantPosition: aTreeNode [
	^ aTreeNode element position x
	
]

{ #category : #accessing }
GtGradHorizontalDominanceTreeLayoutExamples >> getNodeLevelVariableAxisDimension: aTreeNode [
	^ aTreeNode element measuredBounds extent  y.
	
]

{ #category : #accessing }
GtGradHorizontalDominanceTreeLayoutExamples >> getNodeLevelVariablePosition: aTreeNode [
	^ aTreeNode element position y

]

{ #category : #example }
GtGradHorizontalDominanceTreeLayoutExamples >> graphWithANodeWithSeveralIncomingEdges [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view.
	aTreeLayout := self dominanceTreeLayout.
	theNodes := self constructGraphWithANodeWithSeveralIncomingEdges key.
	view addChildren: theNodes.
	view layout: aTreeLayout.
	view forceLayout.
	
	self checkPositionsOfTreesAndNodes:	theNodes layout: aTreeLayout.

	^ view
]

{ #category : #accessing }
GtGradHorizontalDominanceTreeLayoutExamples >> nodeMaximumPoint: aTreeNode [
	^ aTreeNode element position y + aTreeNode element measuredBounds extent y.
]

{ #category : #accessing }
GtGradHorizontalDominanceTreeLayoutExamples >> nodeMinimumPoint: aTreeNode [
	^ aTreeNode element position y
]

{ #category : #example }
GtGradHorizontalDominanceTreeLayoutExamples >> simpleDominanceTreeWith5Nodes [
	<gtExample>
	| view theNodes aTreeLayout |
	
	view := self view.
	theNodes := self constructDominanceTreeWith5Nodes key.
	view addChildren: theNodes. 
	aTreeLayout := self dominanceTreeLayout.
	view layout: aTreeLayout.
	view forceLayout.
	
	self checkPositionsOfTreesAndNodes:	theNodes layout: aTreeLayout.
		
	^ view

]
