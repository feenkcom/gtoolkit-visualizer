"
1. Horizontal tree layout

This layout orders a graph nodes so that they form a horizontal  tree, meaning that the root node is left of all other nodes.

1. Separated and compact subtrees
Tree layout allows users to choose between compact and separated subtrees, it can be done by setting {{gtMethod:GtGradAbstractTreeLayout>>#separateSubtrees:}} either to `true` or `false`.
The following example shows a compact (default) version of the tree:
{{gtExample:GtGradHorizontalTreeLayoutExamples>>#compactSubtrees|codeExpanded=false|previewExpanded=true|previewShow=#gtPreviewFor:|previewHeight=90}}
while the next one is a separated tree:
{{gtExample:GtGradHorizontalTreeLayoutExamples>>#separatedSubtrees|codeExpanded=false|previewExpanded=true|previewShow=#gtPreviewFor:|previewHeight=110}}


"
Class {
	#name : #GtGradHorizontalTreeLayoutExamples,
	#superclass : #GtGradTreeLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'examples - layout' }
GtGradHorizontalTreeLayoutExamples >> binaryTreeWith15Nodes [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructBinaryTreeWith15Nodes.

	aTreeLayout := self treeLayout.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children layoutBounds equals: {
		(0.0@77.0) corner: (50.0@97.0).
		(61.0@33.0) corner: (111.0@53.0).
		(61.0@121.0) corner: (111.0@141.0).
		(122.0@11.0) corner: (172.0@31.0).
		(122.0@55.0) corner: (172.0@75.0).
		(122.0@99.0) corner: (172.0@119.0).
		(122.0@143.0) corner: (172.0@163.0).
		(183.0@0.0) corner: (233.0@20.0).
		(183.0@22.0) corner: (233.0@42.0).
		(183.0@44.0) corner: (233.0@64.0).
		(183.0@66.0) corner: (233.0@86.0).
		(183.0@88.0) corner: (233.0@108.0).
		(183.0@110.0) corner: (233.0@130.0).
		(183.0@132.0) corner: (233.0@152.0).
		(183.0@154.0) corner: (233.0@174.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradHorizontalTreeLayoutExamples >> binaryTreeWith15NodesReversed [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructBinaryTreeWith15Nodes.

	aTreeLayout := self treeLayout reverse: true.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
		(183.0@77.0) corner: (233.0@97.0).
		(122.0@33.0) corner: (172.0@53.0).
		(122.0@121.0) corner: (172.0@141.0).
		(61.0@11.0) corner: (111.0@31.0).
		(61.0@55.0) corner: (111.0@75.0).
		(61.0@99.0) corner: (111.0@119.0).
		(61.0@143.0) corner: (111.0@163.0).
		(0.0@0.0) corner: (50.0@20.0).
		(0.0@22.0) corner: (50.0@42.0).
		(0.0@44.0) corner: (50.0@64.0).
		(0.0@66.0) corner: (50.0@86.0).
		(0.0@88.0) corner: (50.0@108.0).
		(0.0@110.0) corner: (50.0@130.0).
		(0.0@132.0) corner: (50.0@152.0).
		(0.0@154.0) corner: (50.0@174.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradHorizontalTreeLayoutExamples >> binaryTreeWith7Nodes [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructBinaryTreeWith7Nodes.

	aTreeLayout := self treeLayout.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children layoutBounds equals: {
		(0.0@33.0) corner: (50.0@53.0).
		(61.0@11.0) corner: (111.0@31.0).
		(61.0@55.0) corner: (111.0@75.0).
		(122.0@0.0) corner: (172.0@20.0).
		(122.0@22.0) corner: (172.0@42.0).
		(122.0@44.0) corner: (172.0@64.0).
		(122.0@66.0) corner: (172.0@86.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradHorizontalTreeLayoutExamples >> binaryTreeWith7NodesRevered [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructBinaryTreeWith7Nodes.

	aTreeLayout := self treeLayout reverse: true.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children layoutBounds equals: {
		(122.0@33.0) corner: (172.0@53.0).
		(61.0@11.0) corner: (111.0@31.0).
		(61.0@55.0) corner: (111.0@75.0).
		(0.0@0.0) corner: (50.0@20.0).
		(0.0@22.0) corner: (50.0@42.0).
		(0.0@44.0) corner: (50.0@64.0).
		(0.0@66.0) corner: (50.0@86.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradHorizontalTreeLayoutExamples >> compactSubtrees [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructTreeWithNodesWithAndWithoutChildrenOnTheSameLevel.

	aTreeLayout := self treeLayout.
	aTreeLayout separateSubtrees: false.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
		(0.0@44.0) corner: (50.0@64.0).
		(61.0@22.0) corner: (111.0@42.0).
		(61.0@44.0) corner: (111.0@64.0).
		(61.0@66.0) corner: (111.0@86.0).
		(122.0@0.0) corner: (172.0@20.0).
		(122.0@22.0) corner: (172.0@42.0).
		(122.0@44.0) corner: (172.0@64.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradHorizontalTreeLayoutExamples >> compactSubtrees2 [
	<gtExample>
	| aParentNode aTreeLayout |
	aParentNode := self
			createGraph: 7
			pairs: {7 -> 1.
					1 -> 2.
					1 -> 3.
					1 -> 4.
					4 -> 5.
					4 -> 6}.

	aTreeLayout := self treeLayout.
	aTreeLayout separateSubtrees: false.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {61.0 @ 22.0 corner: 111.0 @ 42.0.
				122.0 @ 0.0 corner: 172.0 @ 20.0.
				122.0 @ 22.0 corner: 172.0 @ 42.0.
				122.0 @ 44.0 corner: 172.0 @ 64.0.
				183.0 @ 33.0 corner: 233.0 @ 53.0.
				183.0 @ 55.0 corner: 233.0 @ 75.0.
				0.0 @ 22.0 corner: 50.0 @ 42.0}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradHorizontalTreeLayoutExamples >> disconnectedGraph [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructDisconnectedGraph.

	aTreeLayout := self treeLayout.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
		(0.0@11.0) corner: (50.0@31.0).
		(61.0@11.0) corner: (111.0@31.0).
		(183.0@22.0) corner: (233.0@42.0).
		(122.0@0.0) corner: (172.0@20.0).
		(122.0@22.0) corner: (172.0@42.0).
		(244.0@11.0) corner: (294.0@31.0).
		(244.0@33.0) corner: (294.0@53.0).
		(0.0@94.0) corner: (50.0@114.0).
		(61.0@83.0) corner: (111.0@103.0).
		(61.0@105.0) corner: (111.0@125.0).
		(122.0@105.0) corner: (172.0@125.0).
		(183.0@105.0) corner: (233.0@125.0)
	}.
	
	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradHorizontalTreeLayoutExamples >> disconnectedGraphBiggerDistance [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructDisconnectedGraph.

	aTreeLayout := self treeLayout.
	aTreeLayout treesDistance: 150.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children layoutBounds equals: {
		(0.0@11.0) corner: (50.0@31.0).
		(61.0@11.0) corner: (111.0@31.0).
		(183.0@22.0) corner: (233.0@42.0).
		(122.0@0.0) corner: (172.0@20.0).
		(122.0@22.0) corner: (172.0@42.0).
		(244.0@11.0) corner: (294.0@31.0).
		(244.0@33.0) corner: (294.0@53.0).
		(0.0@214.0) corner: (50.0@234.0).
		(61.0@203.0) corner: (111.0@223.0).
		(61.0@225.0) corner: (111.0@245.0).
		(122.0@225.0) corner: (172.0@245.0).
		(183.0@225.0) corner: (233.0@245.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradHorizontalTreeLayoutExamples >> disconnectedGraphWithRootsOfDifferentSize [	
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructDisconnectedGraphWithRootsOfDifferentSizes.

	aTreeLayout := self treeLayout.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children layoutBounds equals: {
		(0.0@0.0) corner: (50.0@50.0).
		(61.0@15.0) corner: (111.0@35.0).
		(183.0@26.0) corner: (233.0@46.0).
		(122.0@4.0) corner: (172.0@24.0).
		(122.0@26.0) corner: (172.0@46.0).
		(244.0@15.0) corner: (294.0@35.0).
		(244.0@37.0) corner: (294.0@57.0).
		(0.0@112.0) corner: (80.0@182.0).
		(91.0@126.0) corner: (141.0@146.0).
		(91.0@148.0) corner: (141.0@168.0).
		(152.0@148.0) corner: (202.0@168.0).
		(213.0@148.0) corner: (263.0@168.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradHorizontalTreeLayoutExamples >> disconnectedGraphWithTreeContainingOneNode [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructDisconnectedGraphWithTreeContainingOneNode.

	aTreeLayout := self treeLayout.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
		(0.0@0.0) corner: (50.0@20.0).
		(0.0@72.0) corner: (50.0@92.0).
		(61.0@50.0) corner: (111.0@70.0).
		(61.0@72.0) corner: (111.0@92.0).
		(61.0@94.0) corner: (111.0@114.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradHorizontalTreeLayoutExamples >> distinctSubtreesBiggerTree [
	<gtExample>
		<noTest>
	| aParentNode aTreeLayout |

	aParentNode := self constructTreeWithNodesWithAndWithoutChildrenOnTheSameLevelBigger.

	aTreeLayout := self treeLayout.
	aTreeLayout separateSubtrees: false.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children layoutBounds equals: {
		(0.0@165.0) corner: (50.0@185.0).
		(61.0@88.0) corner: (111.0@108.0).
		(61.0@242.0) corner: (111.0@262.0).
		(122.0@22.0) corner: (172.0@42.0).
		(122.0@88.0) corner: (172.0@108.0).
		(122.0@154.0) corner: (172.0@174.0).
		(122.0@220.0) corner: (172.0@240.0).
		(122.0@242.0) corner: (172.0@262.0).
		(122.0@264.0) corner: (172.0@284.0).
		(183.0@0.0) corner: (233.0@20.0).
		(183.0@22.0) corner: (233.0@42.0).
		(183.0@44.0) corner: (233.0@64.0).
		(183.0@66.0) corner: (233.0@86.0).
		(183.0@88.0) corner: (233.0@108.0).
		(183.0@110.0) corner: (233.0@130.0).
		(183.0@132.0) corner: (233.0@152.0).
		(183.0@154.0) corner: (233.0@174.0).
		(183.0@176.0) corner: (233.0@196.0).
		(183.0@198.0) corner: (233.0@218.0).
		(183.0@220.0) corner: (233.0@240.0).
		(183.0@242.0) corner: (233.0@262.0).
		(244.0@231.0) corner: (294.0@251.0).
		(244.0@253.0) corner: (294.0@273.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradHorizontalTreeLayoutExamples >> graphWithANodeWithSeveralIncomingEdges [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructGraphWithANodeWithSeveralIncomingEdges.

	aTreeLayout := self treeLayout.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children layoutBounds equals: {
		(0.0@33.0) corner: (50.0@53.0).
		(61.0@0.0) corner: (111.0@20.0).
		(61.0@22.0) corner: (111.0@42.0).
		(61.0@44.0) corner: (111.0@64.0).
		(61.0@66.0) corner: (111.0@86.0).
		(122.0@0.0) corner: (172.0@20.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradHorizontalTreeLayoutExamples >> graphWithCycles [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructGraphWithCycles.

	aTreeLayout := self treeLayout.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
		(0.0@11.0) corner: (50.0@31.0).
		(61.0@11.0) corner: (111.0@31.0).
		(183.0@22.0) corner: (233.0@42.0).
		(122.0@0.0) corner: (172.0@20.0).
		(122.0@22.0) corner: (172.0@42.0).
		(244.0@11.0) corner: (294.0@31.0).
		(244.0@33.0) corner: (294.0@53.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradHorizontalTreeLayoutExamples >> separatedSubtrees [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructTreeWithNodesWithAndWithoutChildrenOnTheSameLevel.

	aTreeLayout := self treeLayout.
	aTreeLayout separateSubtrees: true.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
		(0.0@55.0) corner: (50.0@75.0).
		(61.0@22.0) corner: (111.0@42.0).
		(61.0@66.0) corner: (111.0@86.0).
		(61.0@88.0) corner: (111.0@108.0).
		(122.0@0.0) corner: (172.0@20.0).
		(122.0@22.0) corner: (172.0@42.0).
		(122.0@44.0) corner: (172.0@64.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradHorizontalTreeLayoutExamples >> simpleTree [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructSimpleTree.

	aTreeLayout := self treeLayout.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children layoutBounds equals: {
		(0.0@82.5) corner: (50.0@102.5).
		(61.0@33.0) corner: (111.0@53.0).
		(61.0@132.0) corner: (111.0@152.0).
		(122.0@11.0) corner: (172.0@31.0).
		(122.0@55.0) corner: (172.0@75.0).
		(122.0@121.0) corner: (172.0@141.0).
		(122.0@143.0) corner: (172.0@163.0).
		(183.0@0.0) corner: (233.0@20.0).
		(183.0@22.0) corner: (233.0@42.0).
		(183.0@44.0) corner: (233.0@64.0).
		(183.0@66.0) corner: (233.0@86.0).
		(183.0@88.0) corner: (233.0@108.0).
		(183.0@110.0) corner: (233.0@130.0).
		(183.0@132.0) corner: (233.0@152.0).
		(183.0@154.0) corner: (233.0@174.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradHorizontalTreeLayoutExamples >> simpleTreeReversed [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructSimpleTree.

	aTreeLayout := self treeLayout reverse: true.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children layoutBounds equals: {
		(183.0@82.5) corner: (233.0@102.5).
		(122.0@33.0) corner: (172.0@53.0).
		(122.0@132.0) corner: (172.0@152.0).
		(61.0@11.0) corner: (111.0@31.0).
		(61.0@55.0) corner: (111.0@75.0).
		(61.0@121.0) corner: (111.0@141.0).
		(61.0@143.0) corner: (111.0@163.0).
		(0.0@0.0) corner: (50.0@20.0).
		(0.0@22.0) corner: (50.0@42.0).
		(0.0@44.0) corner: (50.0@64.0).
		(0.0@66.0) corner: (50.0@86.0).
		(0.0@88.0) corner: (50.0@108.0).
		(0.0@110.0) corner: (50.0@130.0).
		(0.0@132.0) corner: (50.0@152.0).
		(0.0@154.0) corner: (50.0@174.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradHorizontalTreeLayoutExamples >> simpleTreeWith10NodesOfIncreasingSizeCenterAlignment [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructTreeWith10NodesOfIncreasingSize.

	aTreeLayout := self treeLayout.
	aTreeLayout nodesAlignment: GtGradTreeNodesCenterAlignment new.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
		(0.0@247.25) corner: (10.0@257.25).
		(26.0@147.5) corner: (46.0@167.5).
		(21.0@327.0) corner: (51.0@357.0).
		(77.0@66.0) corner: (117.0@106.0).
		(72.0@199.0) corner: (122.0@249.0).
		(67.0@276.0) corner: (127.0@336.0).
		(62.0@338.0) corner: (132.0@408.0).
		(153.0@0.0) corner: (233.0@80.0).
		(148.0@82.0) corner: (238.0@172.0).
		(143.0@174.0) corner: (243.0@274.0)
	}.
	
	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradHorizontalTreeLayoutExamples >> simpleTreeWith10NodesOfIncreasingSizeLeafAlignment [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructTreeWith10NodesOfIncreasingSize.

	aTreeLayout := self treeLayout.
	aTreeLayout nodesAlignment: GtGradTreeNodesLeafAlignment new.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
		(0.0@247.25) corner: (10.0@257.25).
		(31.0@147.5) corner: (51.0@167.5).
		(21.0@327.0) corner: (51.0@357.0).
		(92.0@66.0) corner: (132.0@106.0).
		(82.0@199.0) corner: (132.0@249.0).
		(72.0@276.0) corner: (132.0@336.0).
		(62.0@338.0) corner: (132.0@408.0).
		(163.0@0.0) corner: (243.0@80.0).
		(153.0@82.0) corner: (243.0@172.0).
		(143.0@174.0) corner: (243.0@274.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradHorizontalTreeLayoutExamples >> simpleTreeWith10NodesOfIncreasingSizeRootAlignment [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructTreeWith10NodesOfIncreasingSize.

	aTreeLayout := self treeLayout.
	aTreeLayout nodesAlignment: GtGradTreeNodesRootAlignment new.
	aTreeLayout levelDistance: 30.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
		(0.0@247.25) corner: (10.0@257.25).
		(41.0@147.5) corner: (61.0@167.5).
		(41.0@327.0) corner: (71.0@357.0).
		(102.0@66.0) corner: (142.0@106.0).
		(102.0@199.0) corner: (152.0@249.0).
		(102.0@276.0) corner: (162.0@336.0).
		(102.0@338.0) corner: (172.0@408.0).
		(203.0@0.0) corner: (283.0@80.0).
		(203.0@82.0) corner: (293.0@172.0).
		(203.0@174.0) corner: (303.0@274.0)
	}.
	
	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradHorizontalTreeLayoutExamples >> simpleTreeWithBiggerDistances [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructSimpleTree.

	aTreeLayout := self treeLayout: 40 nodeDistance: 30.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children layoutBounds equals: {
		(0.0@300.0) corner: (50.0@320.0).
		(120.0@120.0) corner: (170.0@140.0).
		(120.0@480.0) corner: (170.0@500.0).
		(240.0@40.0) corner: (290.0@60.0).
		(240.0@200.0) corner: (290.0@220.0).
		(240.0@440.0) corner: (290.0@460.0).
		(240.0@520.0) corner: (290.0@540.0).
		(360.0@0.0) corner: (410.0@20.0).
		(360.0@80.0) corner: (410.0@100.0).
		(360.0@160.0) corner: (410.0@180.0).
		(360.0@240.0) corner: (410.0@260.0).
		(360.0@320.0) corner: (410.0@340.0).
		(360.0@400.0) corner: (410.0@420.0).
		(360.0@480.0) corner: (410.0@500.0).
		(360.0@560.0) corner: (410.0@580.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradHorizontalTreeLayoutExamples >> simpleTreeWithNodesOfDifferentSizes [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructTreeWithNodesOfDifferentSizes.

	aTreeLayout := self treeLayout.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children layoutBounds equals: {
		(0.0@97.0) corner: (50.0@117.0).
		(61.0@0.0) corner: (101.0@40.0).
		(61.0@42.0) corner: (161.0@142.0).
		(61.0@144.0) corner: (131.0@214.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradHorizontalTreeLayoutExamples >> simpleTreeWithNodesOfIncreasingSizeCenterAlignment [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructTreeWithNodesOfIncreasingSize.

	aTreeLayout := self treeLayout.
	aTreeLayout nodesAlignment: GtGradTreeNodesCenterAlignment new.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children layoutBounds equals: {
		(0.0@499.5) corner: (10.0@509.5).
		(26.0@175.5) corner: (46.0@195.5).
		(21.0@803.5) corner: (51.0@833.5).
		(77.0@66.0) corner: (117.0@106.0).
		(72.0@255.0) corner: (122.0@305.0).
		(67.0@631.0) corner: (127.0@691.0).
		(62.0@936.0) corner: (132.0@1006.0).
		(178.0@0.0) corner: (258.0@80.0).
		(173.0@82.0) corner: (263.0@172.0).
		(168.0@174.0) corner: (268.0@274.0).
		(163.0@276.0) corner: (273.0@386.0).
		(158.0@388.0) corner: (278.0@508.0).
		(153.0@510.0) corner: (283.0@640.0).
		(148.0@642.0) corner: (288.0@782.0).
		(143.0@784.0) corner: (293.0@934.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradHorizontalTreeLayoutExamples >> simpleTreeWithNodesOfIncreasingSizeLeafAlignment [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructTreeWithNodesOfIncreasingSize.

	aTreeLayout := self treeLayout.
	aTreeLayout nodesAlignment: GtGradTreeNodesLeafAlignment new.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children layoutBounds equals: {
		(0.0@499.5) corner: (10.0@509.5).
		(31.0@175.5) corner: (51.0@195.5).
		(21.0@803.5) corner: (51.0@833.5).
		(92.0@66.0) corner: (132.0@106.0).
		(82.0@255.0) corner: (132.0@305.0).
		(72.0@631.0) corner: (132.0@691.0).
		(62.0@936.0) corner: (132.0@1006.0).
		(213.0@0.0) corner: (293.0@80.0).
		(203.0@82.0) corner: (293.0@172.0).
		(193.0@174.0) corner: (293.0@274.0).
		(183.0@276.0) corner: (293.0@386.0).
		(173.0@388.0) corner: (293.0@508.0).
		(163.0@510.0) corner: (293.0@640.0).
		(153.0@642.0) corner: (293.0@782.0).
		(143.0@784.0) corner: (293.0@934.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradHorizontalTreeLayoutExamples >> simpleTreeWithNodesOfIncreasingSizeRootAlignment [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructTreeWithNodesOfIncreasingSize.

	aTreeLayout := self treeLayout.
	aTreeLayout nodesAlignment: GtGradTreeNodesRootAlignment new.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
		(0.0@499.5) corner: (10.0@509.5).
		(21.0@175.5) corner: (41.0@195.5).
		(21.0@803.5) corner: (51.0@833.5).
		(62.0@66.0) corner: (102.0@106.0).
		(62.0@255.0) corner: (112.0@305.0).
		(62.0@631.0) corner: (122.0@691.0).
		(62.0@936.0) corner: (132.0@1006.0).
		(143.0@0.0) corner: (223.0@80.0).
		(143.0@82.0) corner: (233.0@172.0).
		(143.0@174.0) corner: (243.0@274.0).
		(143.0@276.0) corner: (253.0@386.0).
		(143.0@388.0) corner: (263.0@508.0).
		(143.0@510.0) corner: (273.0@640.0).
		(143.0@642.0) corner: (283.0@782.0).
		(143.0@784.0) corner: (293.0@934.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradHorizontalTreeLayoutExamples >> simpleTreeWithSmallerDistances [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructSimpleTree.

	aTreeLayout := self treeLayout: 5 nodeDistance: 1.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children layoutBounds equals: {
		(0.0@82.5) corner: (50.0@102.5).
		(56.0@33.0) corner: (106.0@53.0).
		(56.0@132.0) corner: (106.0@152.0).
		(112.0@11.0) corner: (162.0@31.0).
		(112.0@55.0) corner: (162.0@75.0).
		(112.0@121.0) corner: (162.0@141.0).
		(112.0@143.0) corner: (162.0@163.0).
		(168.0@0.0) corner: (218.0@20.0).
		(168.0@22.0) corner: (218.0@42.0).
		(168.0@44.0) corner: (218.0@64.0).
		(168.0@66.0) corner: (218.0@86.0).
		(168.0@88.0) corner: (218.0@108.0).
		(168.0@110.0) corner: (218.0@130.0).
		(168.0@132.0) corner: (218.0@152.0).
		(168.0@154.0) corner: (218.0@174.0)
	}.
	
	^ aParentNode
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
