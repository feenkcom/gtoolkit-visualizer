Class {
	#name : #GtGradVerticalDominanceTreeLayoutExamples,
	#superclass : #GtGradDominanceTreeLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'examples - instance creation' }
GtGradVerticalDominanceTreeLayoutExamples >> distinctSubtrees [
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
GtGradVerticalDominanceTreeLayoutExamples >> dominanceTreeLayout [
	<gtExample>
	|  aTreeLayout |

	aTreeLayout := GtGradVerticalDominanceTreeLayout new.
	self assert: aTreeLayout levelDistance equals: 10.
	self assert: aTreeLayout nodeDistance equals: 1.

		
	^ aTreeLayout
]

{ #category : #'examples - instance creation' }
GtGradVerticalDominanceTreeLayoutExamples >> dominanceTreeWithMultiplePathsToANodesWith8Nodes [
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
GtGradVerticalDominanceTreeLayoutExamples >> dominanceTreeWithMultiplePathsToANodesWith9Nodes [
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
GtGradVerticalDominanceTreeLayoutExamples >> getNodeLevelConstantPosition: aTreeNode [
	^ aTreeNode element position y
	
]

{ #category : #'examples - instance creation' }
GtGradVerticalDominanceTreeLayoutExamples >> getNodeLevelVariableAxisDimension: aTreeNode [
	^ aTreeNode element measuredBounds extent  x.
	
]

{ #category : #'examples - instance creation' }
GtGradVerticalDominanceTreeLayoutExamples >> getNodeLevelVariablePosition: aTreeNode [
	^ aTreeNode element position x

]

{ #category : #'examples - instance creation' }
GtGradVerticalDominanceTreeLayoutExamples >> graphWithANodeWithSeveralIncomingEdges [
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
GtGradVerticalDominanceTreeLayoutExamples >> nodeMaximumPoint: aTreeNode [
	^ aTreeNode element position x + aTreeNode element measuredBounds extent x.
]

{ #category : #'examples - instance creation' }
GtGradVerticalDominanceTreeLayoutExamples >> nodeMinimumPoint: aTreeNode [
	^ aTreeNode element position x
]

{ #category : #'examples - instance creation' }
GtGradVerticalDominanceTreeLayoutExamples >> simpleDominanceTreeWith5Nodes [
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
