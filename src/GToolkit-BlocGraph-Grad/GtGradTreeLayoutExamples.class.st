"
!Tree layout
This layout orders a graph's nodes in such a way that they form  a tree. The layout supports creation of both vertical and horizontal trees. In the first case the root node is at the top, with all of the other nodes being bellow it, as seen in the following example:
${example:name=GtGradVerticalTreeLayoutExamples>>#simpleTree|codeExpanded=false|previewExpanded=true|previewShow=gtPreviewFor:|previewHeight=115}$

On the other hand,  in case of a  horizontal tree , the root node is placed to the left of all other nodes. An example can be seen below:
${example:name=GtGradHorizontalTreeLayoutExamples>>#simpleTree|codeExpanded=false|previewExpanded=true|previewShow=gtPreviewFor:|previewHeight=175}$
!! Distances between levels and nodes
The layout allows customization of distances between levels of the tree, as well as the nodes. The default value of distance between nodes is 1, meaning that the nodes on the same level are very close to each other.  The default value of level distance is 10. The next examples showcase horizontal and vertical trees created using firstly larger than default values of the  distances, and, secondly, with a smaller level distance.

Big distances:
${example:name=GtGradVerticalTreeLayoutExamples>>#simpleTreeWithBiggerDistances|codeExpanded=false|previewExpanded=true|previewShow=gtPreviewFor:|previewHeight=290}$
Small distances:
${example:name=GtGradVerticalTreeLayoutExamples>>#simpleTreeWithSmallerDistances|codeExpanded=false|previewExpanded=true|previewShow=gtPreviewFor:|previewHeight=100}$
!!Graphs with cycles
The layout can also handle graph which are not trees. This is done by firstly traversing the graph using DFS and forming a tree.  
An example of this feature shown bellow:
${example:name=GtGradVerticalTreeLayoutExamples>>#graphWithCycles|codeExpanded=false|previewExpanded=true|previewShow=gtPreviewFor:|previewHeight=145}$
!! Disconnected graphs
Additionally, if the layout handles laying out a disconnected graph. That is, a graph that contains several disconnected components.
It is possible to configure the distance between trees, as demonstrated by the next examples,  with the first one having the
default distance between trees, and the second one a larger value of the distance parameter. The examples also demonstrate that disconnected horizontal trees are positioned one below the other, while in case of vertical trees, these components of a graph are placed one left/right of each other.
${example:name=GtGradVerticalTreeLayoutExamples>>#disconnectedGraph|codeExpanded=false|previewExpanded=true|previewShow=gtPreviewFor:|previewHeight=145}$
!! Alignment
Another important aspect of the tree layout is that it supports alignment of nodes. More precisely, it can be specified if the nodes should have root, center or leaf alignment. In case of the horizontal layout, this actually means that nodes will have left, ceter or right alignment. Examples of different alignmets are shown in the next couple of examples:
!!!!Root alignment
${example:name=GtGradVerticalTreeLayoutExamples>>#simpleTreeWith10NodesOfIncreasingSizeRootAlignment|codeExpanded=false|previewExpanded=true|previewShow=#gtPreviewFor:|previewHeight=305}$
!!!!Center alignment
${example:name=GtGradVerticalTreeLayoutExamples>>#simpleTreeWith10NodesOfIncreasingSizeCenterAlignment|codeExpanded=false|previewExpanded=true|previewShow=gtPreviewFor:|previewHeight=245}$
!!!!Leaf alignment
${example:name=GtGradVerticalTreeLayoutExamples>>#simpleTreeWith10NodesOfIncreasingSizeLeafAlignment|codeExpanded=false|previewExpanded=true|previewShow=gtPreviewFor:|previewHeight=250}$
!!Reversed trees
The trees can be reversed, so that in case of  a vertical tree, the root node is at the bottom, while in case of the horizontal tree, the root node is to the right of the all other nodes. The two examples are shown next:
${example:name=GtGradVerticalTreeLayoutExamples>>#simpleTreeReversed|codeExpanded=false|previewExpanded=true|previewShow=gtPreviewFor:|previewHeight=115}$
!!Separated and compact subtrees
Tree layout allows users to choose between compact and separated subtrees, it can be done by setting ${method:GtGradAbstractTreeLayout>>#separateSubtrees:}$ either to ==true== or ==false==.
The following example shows a compact (default) version of the tree:
${example:GtGradVerticalTreeLayoutExamples>>#compactSubtrees|codeExpanded=false|previewExpanded=true|previewShow=#gtPreviewFor:|previewHeight=85}$
while the next one is a separated tree:
${example:GtGradVerticalTreeLayoutExamples>>#separatedSubtrees|codeExpanded=false|previewExpanded=true|previewShow=#gtPreviewFor:|previewHeight=85}$
"
Class {
	#name : #GtGradTreeLayoutExamples,
	#superclass : #GtGradAbstractTreeLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'examples - layout' }
GtGradTreeLayoutExamples >> binaryTreeWith15Nodes [
	^ self subclassResponsibility
]

{ #category : #'examples - layout' }
GtGradTreeLayoutExamples >> binaryTreeWith15NodesReversed [
	^ self subclassResponsibility
]

{ #category : #'examples - layout' }
GtGradTreeLayoutExamples >> binaryTreeWith7Nodes [
	^ self subclassResponsibility
]

{ #category : #'examples - instance creation' }
GtGradTreeLayoutExamples >> constructBinaryTreeWith15Nodes [
	<gtExample>		
	| aParentNode theNodes |
	
	aParentNode := self
		createGraph: 15
		pairs: {
			(1->2). (1->3).
			(2->4). (2->5).
			(3->6). (3->7).
			(4->8). (4->9).
			(5->10). (5->11).
			(6->12). (6->13).
			(7->14). (7->15) }.

	theNodes := aParentNode children.

	self assert: (theNodes at: 1) nodesAlongOutgoingEdges size equals: 2.
	self assert: (theNodes at: 1) nodesAlongIncomingEdges size equals: 0.
	self assert: (theNodes at: 2) nodesAlongOutgoingEdges size equals: 2.
	self assert: (theNodes at: 2) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 2) connectedNodes size equals: 3.
	self assert: (theNodes at: 14) nodesAlongOutgoingEdges size equals: 0. 
	self assert: (theNodes at: 14) nodesAlongIncomingEdges size equals: 1. 
	self assert: (theNodes at: 15) nodesAlongOutgoingEdges size equals: 0.
	self assert: (theNodes at: 15) nodesAlongIncomingEdges size equals: 1.

	^ aParentNode
]

{ #category : #'examples - instance creation' }
GtGradTreeLayoutExamples >> constructBinaryTreeWith7Nodes [
	<gtExample>

	^ self
		createGraph: 7
		pairs: {
			(1->2). (1->3).
			(2->4). (2->5).
			(3->6). (3->7) }
]

{ #category : #'examples - instance creation' }
GtGradTreeLayoutExamples >> constructDisconnectedGraph [
	<gtExample>

	^ self
		createGraph: 12
		pairs: {
			(1->2). (1->3).
			(2->4). (2->5).
			(3->6). (3->7).
			(6->2). (5->3).
			(8->9). (8->10).
			(10->11). (11->12) }
]

{ #category : #'examples - instance creation' }
GtGradTreeLayoutExamples >> constructDisconnectedGraphWithRootsOfDifferentSizes [
	<gtExample>
	| aParentNode theNodes |

	aParentNode := self
		createGraph: 12
		pairs: {
			(1->2). (1->3).
			(2->4). (2->5).
			(3->6). (3->7).
			(6->2). (5->3).
			(8->9). (8->10).
			(10->11).
			(11->12) }.
		
	theNodes := aParentNode children.

	(theNodes at: 1) measurement extent: 50@50.
	(theNodes at: 8) measurement extent: 80@70.

	^ aParentNode
]

{ #category : #'examples - instance creation' }
GtGradTreeLayoutExamples >> constructDisconnectedGraphWithTreeContainingOneNode [
	<gtExample>

	^  self
		createGraph: 5
		pairs: { (2->3). (2->4). (2->5) }
]

{ #category : #'examples - instance creation' }
GtGradTreeLayoutExamples >> constructForest: theNodes [
	^ GtGradDFSTreeForest from: theNodes separateSubtrees: false
]

{ #category : #'examples - instance creation' }
GtGradTreeLayoutExamples >> constructGraphWithCycles [
	<gtExample>
	
	^ self
		createGraph: 7
		pairs: { (1->2). (1->3). (2->4). (2->5). (3->6). (3->7). (6->2). (5->3) }
]

{ #category : #'examples - instance creation' }
GtGradTreeLayoutExamples >> constructSimpleTree [
	<gtExample>
	
	^ self
		createGraph: 15
		pairs: {
			(1->2). (1->3).
			(2->4). (2->5).
			(3->6). (3->7).
			(4->8). (4->9).
			(5->10). (5->11).
			(6->12). (6->13).
			(6->14). (6->15) }
]

{ #category : #'examples - instance creation' }
GtGradTreeLayoutExamples >> constructTreeWith10NodesOfIncreasingSize [
	<gtExample>
	| aParentNode theNodes |
	
	aParentNode := self
		createGraph: 10
		pairs: {
			(1->2). (1->3).
			(2->4). (2->5).
			(3->6). (3->7).
			(4->8). (4->9).
			(5->10) }.
	
	theNodes := aParentNode children.
	
	theNodes doWithIndex: [ :aNodeElement :index |
		aNodeElement measurement extent: 10 asPoint * index ].

	^ aParentNode
]

{ #category : #'examples - instance creation' }
GtGradTreeLayoutExamples >> constructTreeWithNodesOfDifferentSizes [
	<gtExample>
	| aParentNode theNodes |

	aParentNode := self
		createGraph: 4
		pairs: { (1->2). (1->3). (1->4) }.
	
	theNodes := aParentNode children.

	(theNodes at: 2) measurement extent: 40@40.
	(theNodes at: 3) measurement extent: 100@100.
	(theNodes at: 4) measurement extent: 70@70.
	
	self assert: (theNodes at: 1) nodesAlongOutgoingEdges size equals: 3.
	self assert: (theNodes at: 1) nodesAlongIncomingEdges size equals: 0.
	self assert: (theNodes at: 2) nodesAlongOutgoingEdges size equals: 0.
	self assert: (theNodes at: 2) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 2) nodesAlongOutgoingEdges size equals: 0.
	self assert: (theNodes at: 2) nodesAlongIncomingEdges size equals: 1.
	self assert: (theNodes at: 2) nodesAlongOutgoingEdges size equals: 0.
	self assert: (theNodes at: 2) nodesAlongIncomingEdges size equals: 1.

	^ aParentNode
]

{ #category : #'examples - instance creation' }
GtGradTreeLayoutExamples >> constructTreeWithNodesOfIncreasingSize [
	<gtExample>
	| aParentNode |
	
	aParentNode := self constructSimpleTree.
	
	aParentNode children doWithIndex: [ :eachChildNode :index |
		eachChildNode measurement extent: 10 asPoint * index ].
	
	^ aParentNode
]

{ #category : #'examples - instance creation' }
GtGradTreeLayoutExamples >> constructTreeWithNodesWithAndWithoutChildrenOnTheSameLevelBigger [
	<gtExample>

	^ self
		createGraph: 23
		pairs: {
			(1->2). (1->3).
			(2->4). (2->5). (2->6).
			(4->10). (4->11). (4->12).
			(5->13). (5->14). (5->15).
			(6->16). (6->17). (6->18).
			(3->7). (3->8). (3->9).
			(7->19). (7->20). (7->21).
			(21->22). (21->23) }
]

{ #category : #'examples - layout' }
GtGradTreeLayoutExamples >> disconnectedGraph [
	^ self subclassResponsibility
]

{ #category : #'examples - layout' }
GtGradTreeLayoutExamples >> disconnectedGraphBiggerDistance [
	^ self subclassResponsibility
]

{ #category : #'examples - layout' }
GtGradTreeLayoutExamples >> disconnectedGraphWithRootsOfDifferentSize [
	^ self subclassResponsibility
]

{ #category : #'examples - layout' }
GtGradTreeLayoutExamples >> disconnectedGraphWithTreeContainingOneNode [
	^ self subclassResponsibility
]

{ #category : #'examples - layout' }
GtGradTreeLayoutExamples >> distinctSubtreesBiggerTree [
	^ self subclassResponsibility
]

{ #category : #'examples - layout' }
GtGradTreeLayoutExamples >> graphWithCycles [
	^ self subclassResponsibility
]

{ #category : #'examples - layout' }
GtGradTreeLayoutExamples >> simpleTree [
	^ self subclassResponsibility
]

{ #category : #'examples - layout' }
GtGradTreeLayoutExamples >> simpleTreeReversed [
	^ self subclassResponsibility
]

{ #category : #'examples - layout' }
GtGradTreeLayoutExamples >> simpleTreeWithBiggerDistances [
	^ self subclassResponsibility
]

{ #category : #'examples - layout' }
GtGradTreeLayoutExamples >> simpleTreeWithNodesOfDifferentSizes [
	^ self subclassResponsibility
]

{ #category : #'examples - layout' }
GtGradTreeLayoutExamples >> simpleTreeWithNodesOfIncreasingSizeCenterAlignment [
	^ self subclassResponsibility
]

{ #category : #'examples - layout' }
GtGradTreeLayoutExamples >> simpleTreeWithNodesOfIncreasingSizeRootAlignment [
	^ self subclassResponsibility
]

{ #category : #'examples - layout' }
GtGradTreeLayoutExamples >> simpleTreeWithSmallerDistances [
	^ self subclassResponsibility
]

{ #category : #'examples - instance creation' }
GtGradTreeLayoutExamples >> treeLayout [
	self subclassResponsibility

]

{ #category : #'examples - instance creation' }
GtGradTreeLayoutExamples >> treeLayout: levelDistance nodeDistance: nodeDistance [
	self subclassResponsibility

]

{ #category : #'examples - instance creation' }
GtGradTreeLayoutExamples >> treeLayout: levelDistance nodeDistance: nodeDistance treesDistance: treesDistance [
	self subclassResponsibility

]
