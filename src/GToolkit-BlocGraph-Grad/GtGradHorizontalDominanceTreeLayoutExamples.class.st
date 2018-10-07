Class {
	#name : #GtGradHorizontalDominanceTreeLayoutExamples,
	#superclass : #GtGradDominanceTreeLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'examples - instance creation' }
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

{ #category : #'examples - instance creation' }
GtGradHorizontalDominanceTreeLayoutExamples >> dominanceTreeLayout [
	<gtExample>
	|  aTreeLayout |

	aTreeLayout := GtGradHorizontalDominanceTreeLayout new.
	self assert: aTreeLayout levelDistance equals: 10.
	self assert: aTreeLayout nodeDistance equals: 1.

	^ aTreeLayout
]

{ #category : #'examples - instance creation' }
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

{ #category : #'examples - instance creation' }
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

{ #category : #'examples - instance creation' }
GtGradHorizontalDominanceTreeLayoutExamples >> getNodeLevelConstantPosition: aTreeNode [
	^ aTreeNode element position x
	
]

{ #category : #'examples - instance creation' }
GtGradHorizontalDominanceTreeLayoutExamples >> getNodeLevelVariableAxisDimension: aTreeNode [
	^ aTreeNode element measuredBounds extent  y.
	
]

{ #category : #'examples - instance creation' }
GtGradHorizontalDominanceTreeLayoutExamples >> getNodeLevelVariablePosition: aTreeNode [
	^ aTreeNode element position y

]

{ #category : #'examples - instance creation' }
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

{ #category : #'examples - instance creation' }
GtGradHorizontalDominanceTreeLayoutExamples >> nodeMaximumPoint: aTreeNode [
	^ aTreeNode element position y + aTreeNode element measuredBounds extent y.
]

{ #category : #'examples - instance creation' }
GtGradHorizontalDominanceTreeLayoutExamples >> nodeMinimumPoint: aTreeNode [
	^ aTreeNode element position y
]

{ #category : #'examples - instance creation' }
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
