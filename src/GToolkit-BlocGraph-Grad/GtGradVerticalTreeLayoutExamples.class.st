"
!Vertical tree layout

This layout orders a graph nodes so that they form a vertical tree, meaning that the root node is at the top, with all other nodes being bellow it. 
"
Class {
	#name : #GtGradVerticalTreeLayoutExamples,
	#superclass : #GtGradTreeLayoutExamples,
	#category : 'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #example }
GtGradVerticalTreeLayoutExamples >> binaryTreeWith15Nodes [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view.
	aTreeLayout := self treeLayout. 
	theNodes := self constructBinaryTreeWith15Nodes key.
	view addChildren: theNodes. 
	view layout: aTreeLayout.
	view forceLayout.
	
	self checkPositionsOfVerticalTreesAndNodes:	theNodes layout: aTreeLayout.

	^ view
]

{ #category : #example }
GtGradVerticalTreeLayoutExamples >> binaryTreeWith15NodesReversed [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view.
	aTreeLayout := self treeLayout.
	aTreeLayout reverse: true.
	theNodes := self constructBinaryTreeWith15Nodes key.
	view addChildren: theNodes.
	view layout: aTreeLayout.
	view forceLayout.
	
	self checkPositionsOfVerticalTreesAndNodes:	theNodes layout: aTreeLayout.

	^ view
]

{ #category : #example }
GtGradVerticalTreeLayoutExamples >> binaryTreeWith7Nodes [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view.
	theNodes := self constructBinaryTreeWith7Nodes key. 
	view addChildren: theNodes. 
	aTreeLayout := self treeLayout.
	view layout: aTreeLayout.
	view forceLayout.
	
	self checkPositionsOfVerticalTreesAndNodes:	theNodes layout: aTreeLayout.
		
	^ view

	
 
]

{ #category : #example }
GtGradVerticalTreeLayoutExamples >> binaryTreeWith7NodesRevered [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view.
	theNodes := self constructBinaryTreeWith7Nodes key.
	view addChildren: theNodes.
	aTreeLayout := self treeLayout.
	aTreeLayout reverse: true.
	view layout: aTreeLayout.
	view forceLayout.
	
	self checkPositionsOfVerticalTreesAndNodes:	theNodes layout: aTreeLayout.
	
	^ view

	
 
]

{ #category : #example }
GtGradVerticalTreeLayoutExamples >> disconnectedGraph [
	<gtExample>
		
	| view theNodes aTreeLayout firstTreeRoot secondTreeRoot |
	
	view := self view. 
	aTreeLayout := self treeLayout.
	theNodes := self constructDisconnectedGraph  key. 
	view addChildren: theNodes.
	view layout: aTreeLayout. 
	view forceLayout. 
	
	firstTreeRoot := theNodes at: 1.
	secondTreeRoot := theNodes at: 8.
	
	self assert: (firstTreeRoot position y ) equals:  (secondTreeRoot position y ).
	
	self checkPositionsOfVerticalTreesAndNodes:	theNodes layout: aTreeLayout.

	^ view
]

{ #category : #example }
GtGradVerticalTreeLayoutExamples >> disconnectedGraphBiggerDistance [
	<gtExample>
		
	| view theNodes aTreeLayout firstTreeRoot secondTreeRoot |
	
	view := self view.
	aTreeLayout := self treeLayout.
	aTreeLayout treesDistance: 150.
	theNodes := self constructDisconnectedGraph key.
	view addChildren: theNodes.
	view layout: aTreeLayout.
	view forceLayout. 

	firstTreeRoot := theNodes at: 1.
	secondTreeRoot := theNodes at: 8.
	
	self assert: (firstTreeRoot position y ) equals:  (secondTreeRoot position y ).
	
	self checkPositionsOfVerticalTreesAndNodes:	theNodes layout: aTreeLayout.

	^ view
]

{ #category : #example }
GtGradVerticalTreeLayoutExamples >> disconnectedGraphWithRootsOfDifferentSize [
	<gtExample>
		
	| view theNodes aTreeLayout firstTreeRoot secondTreeRoot |
	
	view := self view.
	aTreeLayout := self treeLayout.
	theNodes := self constructDisconnectedGraphWithRootsOfDifferentSizes key.
	view addChildren: theNodes.
	view layout: aTreeLayout. 
	view forceLayout. 

	firstTreeRoot := theNodes at: 1.
	secondTreeRoot := theNodes at: 8.
	
	self assert: (firstTreeRoot position y ) equals:  (secondTreeRoot position y ).
	
	self checkPositionsOfVerticalTreesAndNodes:	theNodes layout: aTreeLayout.

	^ view
]

{ #category : #example }
GtGradVerticalTreeLayoutExamples >> disconnectedGraphWithTreeContainingOneNode [
	<gtExample>
		
	|  view theNodes aTreeLayout firstTreeRoot secondTreeRoot  |
	
	view := self view. 
	aTreeLayout := self treeLayout.
	theNodes := self constructDisconnectedGraphWithTreeContainingOneNode key.
	view addChildren: theNodes.
	view layout: aTreeLayout.
	view forceLayout. 
	
	firstTreeRoot := theNodes at: 1.
	secondTreeRoot := theNodes at: 2.
	
	self assert: (firstTreeRoot position y ) equals:  (secondTreeRoot position y ).
	
	self checkPositionsOfVerticalTreesAndNodes:	theNodes layout: aTreeLayout.
	
	^ view
]

{ #category : #example }
GtGradVerticalTreeLayoutExamples >> distinctSubtrees [
	<gtExample>
		
	| view theNodes aTreeLayout|
	
	view := self view.
	aTreeLayout := self treeLayout.
	aTreeLayout separateSubtrees: true. 
	theNodes := self constructTreeWithNodesWithAndWithoutChildrenOnTheSameLevel key.
	view addChildren: theNodes.
	view layout: aTreeLayout.
	view forceLayout.
	
	self checkPositionsOfVerticalTreesAndNodes:	theNodes layout: aTreeLayout.

	^ view
]

{ #category : #example }
GtGradVerticalTreeLayoutExamples >> distinctSubtreesBiggerTree [
	<gtExample>
		
	| view theNodes aTreeLayout|
	
	view := self view.
	aTreeLayout := self treeLayout.
	aTreeLayout separateSubtrees: true.
	theNodes := self constructTreeWithNodesWithAndWithoutChildrenOnTheSameLevelBigger key.
	view addChildren: theNodes.
	view layout: aTreeLayout. 
	view forceLayout.
	
	self checkPositionsOfVerticalTreesAndNodes:	theNodes layout: aTreeLayout.

	^ view
]

{ #category : #example }
GtGradVerticalTreeLayoutExamples >> graphWithANodeWithSeveralIncomingEdges [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view.
	aTreeLayout := self treeLayout.
	theNodes := self constructGraphWithANodeWithSeveralIncomingEdges key.
	view addChildren: theNodes.
	view layout: aTreeLayout.
	view forceLayout.
	
	self checkPositionsOfVerticalTreesAndNodes:	theNodes layout: aTreeLayout.

	^ view
]

{ #category : #example }
GtGradVerticalTreeLayoutExamples >> graphWithCycles [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view. 
	aTreeLayout := self treeLayout.
	theNodes := self constructGraphWithCycles key.
	view addChildren: theNodes.
	view layout: aTreeLayout.
	view forceLayout.
	
	self checkPositionsOfVerticalTreesAndNodes:	theNodes layout: aTreeLayout.

	^ view
]

{ #category : #example }
GtGradVerticalTreeLayoutExamples >> simpleTree [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view. 
	aTreeLayout := self treeLayout.
	theNodes := self constructSimpleTree key.
	view addChildren: theNodes.
	view layout: aTreeLayout.
	view forceLayout.
	
	self checkPositionsOfVerticalTreesAndNodes:	theNodes layout: aTreeLayout.

	^ view
]

{ #category : #example }
GtGradVerticalTreeLayoutExamples >> simpleTreeReversed [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view. 
	aTreeLayout := self treeLayout.
	aTreeLayout reverse: true.
	theNodes := self constructSimpleTree key.
	view addChildren: theNodes.
	view layout: aTreeLayout.
	view forceLayout.
	
	self checkPositionsOfVerticalTreesAndNodes:	theNodes layout: aTreeLayout.

	^ view
]

{ #category : #example }
GtGradVerticalTreeLayoutExamples >> simpleTreeWith10NodesOfIncreasingSizeBottomAlignment [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view. 
	aTreeLayout := self treeLayout.
	aTreeLayout nodesAlignment: GtGradTreeNodesBottomAlignment new.
	theNodes := self constructTreeWith10NodesOfIncreasingSize key.
	view addChildren: theNodes.
	view layout: aTreeLayout.
	view forceLayout. 
	 
	self checkPositionsOfVerticalTreesAndNodes:	theNodes layout: aTreeLayout.
	
	^ view
]

{ #category : #example }
GtGradVerticalTreeLayoutExamples >> simpleTreeWith10NodesOfIncreasingSizeCenterAlignment [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view. 
	aTreeLayout := self treeLayout.
	aTreeLayout nodesAlignment: GtGradTreeNodesCenterAlignment new.
	theNodes := self constructTreeWith10NodesOfIncreasingSize key.
	view addChildren: theNodes.
	view layout: aTreeLayout.
	view forceLayout.
	
	self checkPositionsOfVerticalTreesAndNodes:	theNodes layout: aTreeLayout.
	 
	^ view
]

{ #category : #example }
GtGradVerticalTreeLayoutExamples >> simpleTreeWith10NodesOfIncreasingSizeTopAlignment [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view. 
	aTreeLayout := self treeLayout.
	aTreeLayout nodesAlignment: GtGradTreeNodesTopAlignment new.
	theNodes := self constructTreeWith10NodesOfIncreasingSize key.
	view addChildren: theNodes.
	view layout: aTreeLayout.
	view forceLayout.
	
	self checkPositionsOfVerticalTreesAndNodes:	theNodes layout: aTreeLayout.

	^ view
]

{ #category : #example }
GtGradVerticalTreeLayoutExamples >> simpleTreeWithBiggerDistances [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view. 
	aTreeLayout := self treeLayout: 40 nodeDistance: 30.
	theNodes := self constructSimpleTree key.
	view addChildren: theNodes. 
	view layout: aTreeLayout.
	view forceLayout.
	
	self checkPositionsOfVerticalTreesAndNodes:	theNodes layout: aTreeLayout.
	
	^ view
]

{ #category : #example }
GtGradVerticalTreeLayoutExamples >> simpleTreeWithNodesOfDifferentSizes [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view. 
	aTreeLayout := self treeLayout. 
	theNodes := self constructTreeWithNodesOfDifferentSizes key.
	view addChildren: theNodes. 
	view layout: aTreeLayout.
	view forceLayout.
	
	self checkPositionsOfVerticalTreesAndNodes:	theNodes layout: aTreeLayout.

	^ view
]

{ #category : #example }
GtGradVerticalTreeLayoutExamples >> simpleTreeWithNodesOfIncreasingSizeBottomAlignment [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view. 
	aTreeLayout := self treeLayout. 
	aTreeLayout nodesAlignment: GtGradTreeNodesBottomAlignment new.
	theNodes := self constructTreeWithNodesOfIncreasingSize key.
	view addChildren: theNodes. 
	view layout: aTreeLayout.
	view forceLayout. 
	
	self checkPositionsOfVerticalTreesAndNodes:	theNodes layout: aTreeLayout.

	^ view
]

{ #category : #example }
GtGradVerticalTreeLayoutExamples >> simpleTreeWithNodesOfIncreasingSizeCenterAlignment [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view. 
	aTreeLayout := self treeLayout. 
	aTreeLayout nodesAlignment: GtGradTreeNodesCenterAlignment new.
	theNodes := self constructTreeWithNodesOfIncreasingSize key.
	view addChildren: theNodes. 
	view layout: aTreeLayout.
	view forceLayout.
	
	self checkPositionsOfVerticalTreesAndNodes:	theNodes layout: aTreeLayout.
	
	^ view
]

{ #category : #example }
GtGradVerticalTreeLayoutExamples >> simpleTreeWithNodesOfIncreasingSizeTopAlignment [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view. 
	aTreeLayout := self treeLayout. 
	aTreeLayout nodesAlignment: GtGradTreeNodesTopAlignment new.
	theNodes := self constructTreeWithNodesOfIncreasingSize key. 
	view addChildren: theNodes.
	view layout: aTreeLayout.
	view forceLayout.
	
	self checkPositionsOfVerticalTreesAndNodes:	theNodes layout: aTreeLayout.

	^ view
]

{ #category : #example }
GtGradVerticalTreeLayoutExamples >> simpleTreeWithSmallerDistances [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view. 
	aTreeLayout := self treeLayout: 5 nodeDistance: 1.
	theNodes := self constructSimpleTree key.
	view addChildren: theNodes. 
	view layout: aTreeLayout.
	view forceLayout.
	
	self checkPositionsOfVerticalTreesAndNodes:	theNodes layout: aTreeLayout.
	
	^ view
]

{ #category : #'examples - instance creation' }
GtGradVerticalTreeLayoutExamples >> treeLayout [
	|  aTreeLayout |

	aTreeLayout := GtGradVerticalTreeLayout new.
	self assert: aTreeLayout levelDistance equals: 10.
	self assert: aTreeLayout nodeDistance equals: 1.

	^ aTreeLayout
]

{ #category : #'examples - instance creation' }
GtGradVerticalTreeLayoutExamples >> treeLayout: levelDistance nodeDistance: nodeDistance [

	<gtExample>
	|  aTreeLayout |

	aTreeLayout := GtGradVerticalTreeLayout new.
 	aTreeLayout levelDistance: levelDistance.
	aTreeLayout nodeDistance: nodeDistance.
										
	self assert: aTreeLayout levelDistance equals: levelDistance.
	self assert: aTreeLayout nodeDistance equals: nodeDistance.

	^ aTreeLayout
]

{ #category : #'examples - instance creation' }
GtGradVerticalTreeLayoutExamples >> treeLayout: levelDistance nodeDistance: nodeDistance treesDistance: treesDistance [

	<gtExample>
	|  aTreeLayout |

	aTreeLayout := GtGradVerticalTreeLayout new.
 	aTreeLayout levelDistance: levelDistance.
	aTreeLayout nodeDistance: nodeDistance.
	aTreeLayout treesDistance: treesDistance.
										
	self assert: aTreeLayout levelDistance equals: levelDistance.
	self assert: aTreeLayout nodeDistance equals: nodeDistance.
	self assert: aTreeLayout treesDistance equals: treesDistance.

	^ aTreeLayout
]
