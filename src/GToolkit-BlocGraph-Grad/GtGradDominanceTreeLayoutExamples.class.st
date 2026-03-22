"
1. Dominance tree layout

This layout is a variation of the tree layout which makes sure that a tree node is placed as deep as 
possible.  So, if a node has more than one incoming edge the tree will be formed in such a way that 
its parent is the deepest of all possible  parents.  An example shown below demonstrates this:

{{gtExample:name=GtGradVerticalDominanceTreeLayoutExamples>>#dominanceTreeWithMultiplePathsToANodesWith9Nodes|expanded=true|previewExpanded=true|previewShow=gtLiveFor:}}

The node on the fourth level is connected to the root node, as well as the rightmost node on the 
third level. The bottommost node is connected to the middle node on the third level and the only 
node on the fifth level.  In case of the simple tree layout, a spanning tree (to which the layout will be 
applied) is contructed using depth-first search. This procedure would create a tree where the 
mentioned bottomost node would be on the fourth level, with its parent being the middle node on 
the third level..

The following example shows the same graph , but laid out using the horizontal dominance tree:

{{gtExample:name=GtGradHorizontalDominanceTreeLayoutExamples>>#dominanceTreeWithMultiplePathsToANodesWith9Nodes|expanded=true|previewExpanded=true|previewShow=gtLiveFor:}}

Other than  different contruction of the tree based on the input graph, there are no other differences 
between this layout and the regular tree layout. Please see its documenation for more details.


"
Class {
	#name : #GtGradDominanceTreeLayoutExamples,
	#superclass : #GtGradAbstractTreeLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'example - instance creation' }
GtGradDominanceTreeLayoutExamples >> constructDominanceTreeWith4NodeCycle [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	^ self
		createGraph: 4
		pairs: {1 -> 2.
				2 -> 3.
				3 -> 4.
				4 -> 1}
]

{ #category : #'example - instance creation' }
GtGradDominanceTreeLayoutExamples >> constructDominanceTreeWith4NodeCycleAndSeparateSubtree [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	^ self
		createGraph: 6
		pairs: {1 -> 2.
				2 -> 3.
				3 -> 4.
				4 -> 1.
				5 -> 6}
]

{ #category : #'example - instance creation' }
GtGradDominanceTreeLayoutExamples >> constructDominanceTreeWith5Nodes [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	^ self
		createGraph: 5
		pairs: {1 -> 2.
				1 -> 3.
				3 -> 4.
				4 -> 5.
				2 -> 5}
]

{ #category : #'example - instance creation' }
GtGradDominanceTreeLayoutExamples >> constructDominanceTreeWithMultiplePathsToANodesWith8Nodes [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	^ self
		createGraph: 8
		pairs: {1 -> 2.
				1 -> 3.
				3 -> 4.
				4 -> 5.
				2 -> 6.
				2 -> 5.
				5 -> 6.
				6 -> 7.
				7 -> 8.
				4 -> 8}
]

{ #category : #'example - instance creation' }
GtGradDominanceTreeLayoutExamples >> constructDominanceTreeWithMultiplePathsToANodesWith9Nodes [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	^ self
		createGraph: 9
		pairs: {1 -> 2.
				1 -> 3.
				2 -> 4.
				2 -> 7.
				2 -> 9.
				3 -> 5.
				5 -> 6.
				6 -> 7.
				7 -> 8.
				9 -> 8}
]

{ #category : #'example - instance creation' }
GtGradDominanceTreeLayoutExamples >> constructDominanceTreeWithMultiplePathsToANodesWith9NodesAndACycle [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	^ self
		createGraph: 9
		pairs: {1 -> 2.
				1 -> 3.
				2 -> 4.
				2 -> 7.
				2 -> 9.
				3 -> 5.
				5 -> 6.
				6 -> 7.
				7 -> 8.
				7 -> 2.
				9 -> 8}
]

{ #category : #'example - instance creation' }
GtGradDominanceTreeLayoutExamples >> constructForest: theNodes [
	^ GtGradDominanceTreeForest from: theNodes separateSubtrees: false
]

{ #category : #'example - instance creation' }
GtGradDominanceTreeLayoutExamples >> dominanceTreeLayout [
	^ self subclassResponsibility
]

{ #category : #'example - layout' }
GtGradDominanceTreeLayoutExamples >> dominanceTreeWithMultiplePathsToANodesWith8Nodes [
	^ self subclassResponsibility
]

{ #category : #'example - layout' }
GtGradDominanceTreeLayoutExamples >> dominanceTreeWithMultiplePathsToANodesWith9Nodes [
	^ self subclassResponsibility
]

{ #category : #'example - layout' }
GtGradDominanceTreeLayoutExamples >> simpleDominanceTreeWith5Nodes [
	^ self subclassResponsibility
]
