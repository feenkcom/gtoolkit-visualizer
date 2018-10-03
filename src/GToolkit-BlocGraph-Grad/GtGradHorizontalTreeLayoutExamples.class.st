"
!Horizontal tree layout

This layout orders a graph nodes so that they form a horizontal  tree, meaning that the root node is left of all other nodes.
"
Class {
	#name : #GtGradHorizontalTreeLayoutExamples,
	#superclass : #GtGradTreeLayoutExamples,
	#category : 'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #example }
GtGradHorizontalTreeLayoutExamples >> binaryTreeWith15Nodes [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view.
	aTreeLayout := self treeLayout.
	theNodes := self constructBinaryTreeWith15Nodes key.
	view addChildren: theNodes.
	view layout: aTreeLayout. 
	view forceLayout.
	
	self checkIfAllChildrenHaveTheSameHorizontalPosition: theNodes.

	^ view
]

{ #category : #example }
GtGradHorizontalTreeLayoutExamples >> binaryTreeWith15NodesReversed [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view.
	aTreeLayout := self treeLayout.
	aTreeLayout reverse: true.
	theNodes := self constructBinaryTreeWith15Nodes key.
	view addChildren: theNodes. 
	view layout: aTreeLayout.
	view forceLayout.
	
	self checkIfAllChildrenHaveTheSameHorizontalPosition: theNodes.

	^ view
]

{ #category : #example }
GtGradHorizontalTreeLayoutExamples >> binaryTreeWith7Nodes [
	<gtExample>
		
	| view theNodes  aTreeLayout |
	
	view := self view. 
	theNodes := self constructBinaryTreeWith7Nodes key.
	view addChildren: theNodes.
	aTreeLayout := self treeLayout.
	view layout: aTreeLayout.
	view forceLayout.
	
	self checkIfAllChildrenHaveTheSameHorizontalPosition: theNodes.

	^ view

	
 
]

{ #category : #example }
GtGradHorizontalTreeLayoutExamples >> binaryTreeWith7NodesReversed [
	<gtExample>
		
	| view theNodes  aTreeLayout |
	
	view := self view.
	theNodes := self constructBinaryTreeWith7Nodes key.
	view addChildren: theNodes.
	aTreeLayout := self treeLayout.
	aTreeLayout reverse: true.
	view layout: aTreeLayout.
	view forceLayout. 
	
	self checkIfAllChildrenHaveTheSameHorizontalPosition: theNodes.

	^ view

	
 
]

{ #category : #example }
GtGradHorizontalTreeLayoutExamples >> disconnectedGraph [
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
	
	self assert: (firstTreeRoot position x ) equals:  (secondTreeRoot position x ).
	
	self checkIfAllChildrenHaveTheSameHorizontalPosition: theNodes.

	^ view
]

{ #category : #example }
GtGradHorizontalTreeLayoutExamples >> disconnectedGraphBiggerDistance [
	<gtExample>
		
	| view theNodes aTreeLayout firstTreeRoot secondTreeRoot |
	
	view := self view.
	aTreeLayout := self treeLayout.
	aTreeLayout treesDistance: 150.
	theNodes := self constructDisconnectedGraph  key.
	view addChildren: theNodes.
	view layout: aTreeLayout.
	view forceLayout. 
	
	firstTreeRoot := theNodes at: 1.
	secondTreeRoot := theNodes at: 8.
	
	self assert: (firstTreeRoot position x ) equals:  (secondTreeRoot position x ).

	self checkIfAllChildrenHaveTheSameHorizontalPosition: theNodes.

	^ view
]

{ #category : #example }
GtGradHorizontalTreeLayoutExamples >> disconnectedGraphWithRootsOfDifferentSize [
	<gtExample>
		
	|  view theNodes aTreeLayout firstTreeRoot secondTreeRoot  |
	
	view := self view. 
	aTreeLayout := self treeLayout.
	theNodes := self constructDisconnectedGraphWithRootsOfDifferentSizes key.
	view addChildren: theNodes.
	view layout: aTreeLayout.
	view forceLayout. 
	
	firstTreeRoot := theNodes at: 1.
	secondTreeRoot := theNodes at: 8.
	
	self assert: (firstTreeRoot position x ) equals:  (secondTreeRoot position x ).
	
	self checkIfAllChildrenHaveTheSameHorizontalPosition: theNodes.
	
	^ view
]

{ #category : #example }
GtGradHorizontalTreeLayoutExamples >> disconnectedGraphWithTreeContainingOneNode [
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
	
	self assert: (firstTreeRoot position x ) equals:  (secondTreeRoot position x ).
	
	self checkIfAllChildrenHaveTheSameHorizontalPosition: theNodes.
	
	^ view
]

{ #category : #example }
GtGradHorizontalTreeLayoutExamples >> distinctSubtrees [
	<gtExample>
		
	| view theNodes aTreeLayout|
	
	view := self view.
	aTreeLayout := self treeLayout.
	aTreeLayout separateSubtrees: true.
	theNodes := self constructTreeWithNodesWithAndWithoutChildrenOnTheSameLevel key.
	view addChildren: theNodes.
	view layout: aTreeLayout. 
	view forceLayout.
	
	self checkIfAllChildrenHaveTheSameHorizontalPosition: theNodes.

	^ view
]

{ #category : #example }
GtGradHorizontalTreeLayoutExamples >> distinctSubtreesBiggerTree [
	<gtExample>
		
	| view theNodes aTreeLayout|
	
	view := self view.
	aTreeLayout := self treeLayout.
	aTreeLayout separateSubtrees: true.
	theNodes := self constructTreeWithNodesWithAndWithoutChildrenOnTheSameLevelBigger key.
	view addChildren: theNodes.
	view layout: aTreeLayout. 
	view forceLayout. 

	self checkIfAllChildrenHaveTheSameHorizontalPosition: theNodes.

	^ view
]

{ #category : #example }
GtGradHorizontalTreeLayoutExamples >> graphWithANodeWithSeveralIncomingEdges [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view.
	aTreeLayout := self treeLayout.
	theNodes := self constructGraphWithANodeWithSeveralIncomingEdges key.
	view addChildren: theNodes.
	view layout: aTreeLayout.
	view forceLayout. 

	self checkIfAllChildrenHaveTheSameHorizontalPosition: theNodes.
	^ view
]

{ #category : #example }
GtGradHorizontalTreeLayoutExamples >> graphWithCycles [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view.
	aTreeLayout := self treeLayout.
	theNodes := self constructGraphWithCycles key.
	view addChildren: theNodes.
	view layout: aTreeLayout.
	view forceLayout. 

	self checkIfAllChildrenHaveTheSameHorizontalPosition: theNodes.
	^ view
]

{ #category : #example }
GtGradHorizontalTreeLayoutExamples >> simpleTree [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view. 
	aTreeLayout := self treeLayout.
	theNodes := self constructSimpleTree key.
	view addChildren: theNodes. 
	view layout: aTreeLayout.
	view forceLayout. 

	self checkIfAllChildrenHaveTheSameHorizontalPosition: theNodes.
	^ view
]

{ #category : #example }
GtGradHorizontalTreeLayoutExamples >> simpleTreeReversed [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view. 
	aTreeLayout := self treeLayout.
	aTreeLayout reverse: true.
	theNodes := self constructSimpleTree key.
	view addChildren: theNodes. 
	view layout: aTreeLayout.
	view forceLayout. 

	self checkIfAllChildrenHaveTheSameHorizontalPosition: theNodes.
	^ view
]

{ #category : #example }
GtGradHorizontalTreeLayoutExamples >> simpleTreeWithBiggerDistances [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view. 
	aTreeLayout := self treeLayout: 40 nodeDistance: 30.
	theNodes := self constructSimpleTree key.
	view addChildren: theNodes.
	view layout: aTreeLayout.
	view forceLayout. 
	
	self checkIfAllChildrenHaveTheSameHorizontalPosition: theNodes.
	^ view
]

{ #category : #example }
GtGradHorizontalTreeLayoutExamples >> simpleTreeWithNodesOfIncreasingBottomAlignment [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view. 
	aTreeLayout := self treeLayout.
	aTreeLayout nodesAlignment: GtGradTreeNodesBottomAlignment new.
	theNodes := self constructTreeWithNodesOfIncreasingSize key. 
	view addChildren: theNodes. 
	view layout: aTreeLayout.
	view forceLayout. 
	 
	self checkIfAllChildrenHaveTheSameHorizontalPosition: theNodes.
	^ view
]

{ #category : #example }
GtGradHorizontalTreeLayoutExamples >> simpleTreeWithNodesOfIncreasingSizeCenterAlignment [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view. 
	aTreeLayout := self treeLayout.
	aTreeLayout nodesAlignment: GtGradTreeNodesCenterAlignment new.
	theNodes := self constructTreeWithNodesOfIncreasingSize key. 
	view addChildren: theNodes.
	view layout: aTreeLayout.
	view forceLayout. 

	self checkIfAllChildrenHaveTheSameHorizontalPosition: theNodes.
	^ view
]

{ #category : #example }
GtGradHorizontalTreeLayoutExamples >> simpleTreeWithNodesOfIncreasingSizeTopAlignment [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view. 
	aTreeLayout := self treeLayout.
	aTreeLayout nodesAlignment: GtGradTreeNodesTopAlignment new.
	theNodes := self constructTreeWithNodesOfIncreasingSize key. 
	view addChildren: theNodes. 
	view layout: aTreeLayout.
	view forceLayout. 

	self checkIfAllChildrenHaveTheSameHorizontalPosition: theNodes.
	^ view
]

{ #category : #example }
GtGradHorizontalTreeLayoutExamples >> simpleTreeWithSmallerDistances [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view. 
	aTreeLayout := self treeLayout: 5 nodeDistance: 1.
	theNodes := self constructSimpleTree key.
	view addChildren: theNodes. 
	view layout: aTreeLayout.
	view forceLayout.
		
	self checkIfAllChildrenHaveTheSameHorizontalPosition: theNodes.
	^ view
]

{ #category : #'examples - instance creation' }
GtGradHorizontalTreeLayoutExamples >> treeLayout [
	<gtExample>
	|  aTreeLayout |

	aTreeLayout := GtGradHorizontalTreeLayout new.
	self assert: aTreeLayout levelDistance equals: 10.
	self assert: aTreeLayout nodeDistance equals: 1.

	^ aTreeLayout
]

{ #category : #'examples - instance creation' }
GtGradHorizontalTreeLayoutExamples >> treeLayout: levelDistance nodeDistance: nodeDistance [

	<gtExample>
	|  aTreeLayout |

	aTreeLayout := GtGradHorizontalTreeLayout new.
	aTreeLayout levelDistance: levelDistance.
	aTreeLayout nodeDistance: nodeDistance.
										
	self assert: aTreeLayout levelDistance equals: levelDistance.
	self assert: aTreeLayout nodeDistance equals: nodeDistance.

	^ aTreeLayout
]

{ #category : #'examples - instance creation' }
GtGradHorizontalTreeLayoutExamples >> treeLayout: levelDistance nodeDistance: nodeDistance treesDistance: treesDistance [

	<gtExample>
	|  aTreeLayout |

	aTreeLayout := GtGradHorizontalTreeLayout new.
 	aTreeLayout levelDistance: levelDistance.
	aTreeLayout nodeDistance: nodeDistance.
	aTreeLayout treesDistance: treesDistance.
										
	self assert: aTreeLayout levelDistance equals: levelDistance.
	self assert: aTreeLayout nodeDistance equals: nodeDistance.
	self assert: aTreeLayout treesDistance equals: treesDistance.

	^ aTreeLayout
]
