"
!Vertical tree layout

This layout orders a graph nodes so that they form a vertical tree, meaning that the root node is at the top, with all other nodes being bellow it. 
"
Class {
	#name : #GtGradVerticalTreeLayoutExamples,
	#superclass : #GtGradTreeLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'examples - layout' }
GtGradVerticalTreeLayoutExamples >> binaryTreeWith15Nodes [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructBinaryTreeWith15Nodes.

	aTreeLayout := self treeLayout.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children measuredBounds equals: {
		(182.0@0.0) corner: (232.0@20.0).
		(78.0@31.0) corner: (128.0@51.0).
		(286.0@31.0) corner: (336.0@51.0).
		(26.0@62.0) corner: (76.0@82.0).
		(130.0@62.0) corner: (180.0@82.0).
		(234.0@62.0) corner: (284.0@82.0).
		(338.0@62.0) corner: (388.0@82.0).
		(0.0@93.0) corner: (50.0@113.0).
		(52.0@93.0) corner: (102.0@113.0).
		(104.0@93.0) corner: (154.0@113.0).
		(156.0@93.0) corner: (206.0@113.0).
		(208.0@93.0) corner: (258.0@113.0).
		(260.0@93.0) corner: (310.0@113.0).
		(312.0@93.0) corner: (362.0@113.0).
		(364.0@93.0) corner: (414.0@113.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradVerticalTreeLayoutExamples >> binaryTreeWith15NodesReversed [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructBinaryTreeWith15Nodes.

	aTreeLayout := self treeLayout reverse: true.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children measuredBounds equals: {
		(182.0@93.0) corner: (232.0@113.0).
		(78.0@62.0) corner: (128.0@82.0).
		(286.0@62.0) corner: (336.0@82.0).
		(26.0@31.0) corner: (76.0@51.0).
		(130.0@31.0) corner: (180.0@51.0).
		(234.0@31.0) corner: (284.0@51.0).
		(338.0@31.0) corner: (388.0@51.0).
		(0.0@0.0) corner: (50.0@20.0).
		(52.0@0.0) corner: (102.0@20.0).
		(104.0@0.0) corner: (154.0@20.0).
		(156.0@0.0) corner: (206.0@20.0).
		(208.0@0.0) corner: (258.0@20.0).
		(260.0@0.0) corner: (310.0@20.0).
		(312.0@0.0) corner: (362.0@20.0).
		(364.0@0.0) corner: (414.0@20.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradVerticalTreeLayoutExamples >> binaryTreeWith7Nodes [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructBinaryTreeWith7Nodes.

	aTreeLayout := self treeLayout.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children measuredBounds equals: {
		(78.0@0.0) corner: (128.0@20.0).
		(26.0@31.0) corner: (76.0@51.0).
		(130.0@31.0) corner: (180.0@51.0).
		(0.0@62.0) corner: (50.0@82.0).
		(52.0@62.0) corner: (102.0@82.0).
		(104.0@62.0) corner: (154.0@82.0).
		(156.0@62.0) corner: (206.0@82.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradVerticalTreeLayoutExamples >> binaryTreeWith7NodesRevered [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructBinaryTreeWith7Nodes.

	aTreeLayout := self treeLayout reverse: true.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children measuredBounds equals: {
		(78.0@62.0) corner: (128.0@82.0).
		(26.0@31.0) corner: (76.0@51.0).
		(130.0@31.0) corner: (180.0@51.0).
		(0.0@0.0) corner: (50.0@20.0).
		(52.0@0.0) corner: (102.0@20.0).
		(104.0@0.0) corner: (154.0@20.0).
		(156.0@0.0) corner: (206.0@20.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradVerticalTreeLayoutExamples >> compactSubtrees [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructTreeWithNodesWithAndWithoutChildrenOnTheSameLevel.

	aTreeLayout := self treeLayout.
	aTreeLayout separateSubtrees: false.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children measuredBounds equals: {
		(108.72727272727272@0.0) corner: (158.72727272727272@20.0).
		(52.0@31.0) corner: (102.0@51.0).
		(113.45454545454544@31.0) corner: (163.45454545454544@51.0).
		(165.45454545454544@31.0) corner: (215.45454545454544@51.0).
		(0.0@62.0) corner: (50.0@82.0).
		(52.0@62.0) corner: (102.0@82.0).
		(104.0@62.0) corner: (154.0@82.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradVerticalTreeLayoutExamples >> disconnectedGraph [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructDisconnectedGraph.

	aTreeLayout := self treeLayout.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children measuredBounds equals: {
		(26.0@0.0) corner: (76.0@20.0).
		(26.0@31.0) corner: (76.0@51.0).
		(52.0@93.0) corner: (102.0@113.0).
		(0.0@62.0) corner: (50.0@82.0).
		(52.0@62.0) corner: (102.0@82.0).
		(26.0@124.0) corner: (76.0@144.0).
		(78.0@124.0) corner: (128.0@144.0).
		(184.0@0.0) corner: (234.0@20.0).
		(158.0@31.0) corner: (208.0@51.0).
		(210.0@31.0) corner: (260.0@51.0).
		(210.0@62.0) corner: (260.0@82.0).
		(210.0@93.0) corner: (260.0@113.0)
	}.
	
	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradVerticalTreeLayoutExamples >> disconnectedGraphBiggerDistance [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructDisconnectedGraph.

	aTreeLayout := self treeLayout.
	aTreeLayout treesDistance: 150.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children measuredBounds equals: {
		(26.0@0.0) corner: (76.0@20.0).
		(26.0@31.0) corner: (76.0@51.0).
		(52.0@93.0) corner: (102.0@113.0).
		(0.0@62.0) corner: (50.0@82.0).
		(52.0@62.0) corner: (102.0@82.0).
		(26.0@124.0) corner: (76.0@144.0).
		(78.0@124.0) corner: (128.0@144.0).
		(304.0@0.0) corner: (354.0@20.0).
		(278.0@31.0) corner: (328.0@51.0).
		(330.0@31.0) corner: (380.0@51.0).
		(330.0@62.0) corner: (380.0@82.0).
		(330.0@93.0) corner: (380.0@113.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradVerticalTreeLayoutExamples >> disconnectedGraphWithRootsOfDifferentSize [	
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructDisconnectedGraphWithRootsOfDifferentSizes.

	aTreeLayout := self treeLayout.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children measuredBounds equals: {
		(26.0@0.0) corner: (76.0@50.0).
		(26.0@61.0) corner: (76.0@81.0).
		(52.0@123.0) corner: (102.0@143.0).
		(0.0@92.0) corner: (50.0@112.0).
		(52.0@92.0) corner: (102.0@112.0).
		(26.0@154.0) corner: (76.0@174.0).
		(78.0@154.0) corner: (128.0@174.0).
		(173.0@0.0) corner: (253.0@70.0).
		(162.0@81.0) corner: (212.0@101.0).
		(214.0@81.0) corner: (264.0@101.0).
		(214.0@112.0) corner: (264.0@132.0).
		(214.0@143.0) corner: (264.0@163.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradVerticalTreeLayoutExamples >> disconnectedGraphWithTreeContainingOneNode [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructDisconnectedGraphWithTreeContainingOneNode.

	aTreeLayout := self treeLayout.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children measuredBounds equals: {
		(0.0@0.0) corner: (50.0@20.0).
		(132.0@0.0) corner: (182.0@20.0).
		(80.0@31.0) corner: (130.0@51.0).
		(132.0@31.0) corner: (182.0@51.0).
		(184.0@31.0) corner: (234.0@51.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradVerticalTreeLayoutExamples >> distinctSubtreesBiggerTree [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructTreeWithNodesWithAndWithoutChildrenOnTheSameLevelBigger.

	aTreeLayout := self treeLayout.
	aTreeLayout separateSubtrees: true.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children measuredBounds equals: {
		(413.9318181818182@0.0) corner: (463.9318181818182@20.0).
		(208.0@31.0) corner: (258.0@51.0).
		(619.8636363636364@31.0) corner: (669.8636363636364@51.0).
		(52.0@62.0) corner: (102.0@82.0).
		(208.0@62.0) corner: (258.0@82.0).
		(364.0@62.0) corner: (414.0@82.0).
		(533.0@62.0) corner: (583.0@82.0).
		(654.7272727272727@62.0) corner: (704.7272727272727@82.0).
		(706.7272727272727@62.0) corner: (756.7272727272727@82.0).
		(0.0@93.0) corner: (50.0@113.0).
		(52.0@93.0) corner: (102.0@113.0).
		(104.0@93.0) corner: (154.0@113.0).
		(156.0@93.0) corner: (206.0@113.0).
		(208.0@93.0) corner: (258.0@113.0).
		(260.0@93.0) corner: (310.0@113.0).
		(312.0@93.0) corner: (362.0@113.0).
		(364.0@93.0) corner: (414.0@113.0).
		(416.0@93.0) corner: (466.0@113.0).
		(468.0@93.0) corner: (518.0@113.0).
		(520.0@93.0) corner: (570.0@113.0).
		(598.0@93.0) corner: (648.0@113.0).
		(572.0@124.0) corner: (622.0@144.0).
		(624.0@124.0) corner: (674.0@144.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradVerticalTreeLayoutExamples >> graphWithANodeWithSeveralIncomingEdges [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructGraphWithANodeWithSeveralIncomingEdges.

	aTreeLayout := self treeLayout.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children measuredBounds equals: {
		(78.0@0.0) corner: (128.0@20.0).
		(0.0@31.0) corner: (50.0@51.0).
		(52.0@31.0) corner: (102.0@51.0).
		(104.0@31.0) corner: (154.0@51.0).
		(156.0@31.0) corner: (206.0@51.0).
		(0.0@62.0) corner: (50.0@82.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradVerticalTreeLayoutExamples >> graphWithCycles [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructGraphWithCycles.

	aTreeLayout := self treeLayout.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children measuredBounds equals: {
		(26.0@0.0) corner: (76.0@20.0).
		(26.0@31.0) corner: (76.0@51.0).
		(52.0@93.0) corner: (102.0@113.0).
		(0.0@62.0) corner: (50.0@82.0).
		(52.0@62.0) corner: (102.0@82.0).
		(26.0@124.0) corner: (76.0@144.0).
		(78.0@124.0) corner: (128.0@144.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradVerticalTreeLayoutExamples >> separatedSubtrees [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructTreeWithNodesWithAndWithoutChildrenOnTheSameLevel.

	aTreeLayout := self treeLayout.
	aTreeLayout separateSubtrees: true.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children measuredBounds equals: {
		(130.0@0.0) corner: (180.0@20.0).
		(52.0@31.0) corner: (102.0@51.0).
		(156.0@31.0) corner: (206.0@51.0).
		(208.0@31.0) corner: (258.0@51.0).
		(0.0@62.0) corner: (50.0@82.0).
		(52.0@62.0) corner: (102.0@82.0).
		(104.0@62.0) corner: (154.0@82.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradVerticalTreeLayoutExamples >> simpleTree [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructSimpleTree.

	aTreeLayout := self treeLayout.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children measuredBounds equals: {
		(198.54545454545456@0.0) corner: (248.54545454545456@20.0).
		(78.0@31.0) corner: (128.0@51.0).
		(319.0909090909091@31.0) corner: (369.0909090909091@51.0).
		(26.0@62.0) corner: (76.0@82.0).
		(130.0@62.0) corner: (180.0@82.0).
		(286.0@62.0) corner: (336.0@82.0).
		(352.1818181818182@62.0) corner: (402.1818181818182@82.0).
		(0.0@93.0) corner: (50.0@113.0).
		(52.0@93.0) corner: (102.0@113.0).
		(104.0@93.0) corner: (154.0@113.0).
		(156.0@93.0) corner: (206.0@113.0).
		(208.0@93.0) corner: (258.0@113.0).
		(260.0@93.0) corner: (310.0@113.0).
		(312.0@93.0) corner: (362.0@113.0).
		(364.0@93.0) corner: (414.0@113.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradVerticalTreeLayoutExamples >> simpleTreeReversed [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructSimpleTree.

	aTreeLayout := self treeLayout reverse: true.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children measuredBounds equals: {
		(198.54545454545456@93.0) corner: (248.54545454545456@113.0).
		(78.0@62.0) corner: (128.0@82.0).
		(319.0909090909091@62.0) corner: (369.0909090909091@82.0).
		(26.0@31.0) corner: (76.0@51.0).
		(130.0@31.0) corner: (180.0@51.0).
		(286.0@31.0) corner: (336.0@51.0).
		(352.1818181818182@31.0) corner: (402.1818181818182@51.0).
		(0.0@0.0) corner: (50.0@20.0).
		(52.0@0.0) corner: (102.0@20.0).
		(104.0@0.0) corner: (154.0@20.0).
		(156.0@0.0) corner: (206.0@20.0).
		(208.0@0.0) corner: (258.0@20.0).
		(260.0@0.0) corner: (310.0@20.0).
		(312.0@0.0) corner: (362.0@20.0).
		(364.0@0.0) corner: (414.0@20.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradVerticalTreeLayoutExamples >> simpleTreeWith10NodesOfIncreasingSizeCenterAlignment [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructTreeWith10NodesOfIncreasingSize.

	aTreeLayout := self treeLayout.
	aTreeLayout nodesAlignment: GtGradTreeNodesCenterAlignment new.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children measuredBounds equals: {
		(247.25@0.0) corner: (257.25@10.0).
		(147.5@26.0) corner: (167.5@46.0).
		(327.0@21.0) corner: (357.0@51.0).
		(66.0@77.0) corner: (106.0@117.0).
		(199.0@72.0) corner: (249.0@122.0).
		(276.0@67.0) corner: (336.0@127.0).
		(338.0@62.0) corner: (408.0@132.0).
		(0.0@153.0) corner: (80.0@233.0).
		(82.0@148.0) corner: (172.0@238.0).
		(174.0@143.0) corner: (274.0@243.0)
	}.
	
	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradVerticalTreeLayoutExamples >> simpleTreeWith10NodesOfIncreasingSizeLeafAlignment [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructTreeWith10NodesOfIncreasingSize.

	aTreeLayout := self treeLayout.
	aTreeLayout nodesAlignment: GtGradTreeNodesLeafAlignment new.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children measuredBounds equals: {
		(247.25@0.0) corner: (257.25@10.0).
		(147.5@31.0) corner: (167.5@51.0).
		(327.0@21.0) corner: (357.0@51.0).
		(66.0@92.0) corner: (106.0@132.0).
		(199.0@82.0) corner: (249.0@132.0).
		(276.0@72.0) corner: (336.0@132.0).
		(338.0@62.0) corner: (408.0@132.0).
		(0.0@163.0) corner: (80.0@243.0).
		(82.0@153.0) corner: (172.0@243.0).
		(174.0@143.0) corner: (274.0@243.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradVerticalTreeLayoutExamples >> simpleTreeWith10NodesOfIncreasingSizeRootAlignment [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructTreeWith10NodesOfIncreasingSize.

	aTreeLayout := self treeLayout.
	aTreeLayout nodesAlignment: GtGradTreeNodesRootAlignment new.
	aTreeLayout levelDistance: 30.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children measuredBounds equals: {
		(243.6209677419355@0.0) corner: (253.6209677419355@10.0).
		(147.5@41.0) corner: (167.5@61.0).
		(319.741935483871@41.0) corner: (349.741935483871@71.0).
		(66.0@102.0) corner: (106.0@142.0).
		(199.0@102.0) corner: (249.0@152.0).
		(268.741935483871@102.0) corner: (328.741935483871@162.0).
		(330.741935483871@102.0) corner: (400.741935483871@172.0).
		(0.0@203.0) corner: (80.0@283.0).
		(82.0@203.0) corner: (172.0@293.0).
		(174.0@203.0) corner: (274.0@303.0)
	}.
	
	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradVerticalTreeLayoutExamples >> simpleTreeWithBiggerDistances [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructSimpleTree.

	aTreeLayout := self treeLayout: 40 nodeDistance: 30.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children measuredBounds equals: {
		(447.8571428571429@0.0) corner: (497.8571428571429@20.0).
		(165.0@90.0) corner: (215.0@110.0).
		(730.7142857142858@90.0) corner: (780.7142857142858@110.0).
		(55.0@180.0) corner: (105.0@200.0).
		(275.0@180.0) corner: (325.0@200.0).
		(605.0@180.0) corner: (655.0@200.0).
		(856.4285714285714@180.0) corner: (906.4285714285714@200.0).
		(0.0@270.0) corner: (50.0@290.0).
		(110.0@270.0) corner: (160.0@290.0).
		(220.0@270.0) corner: (270.0@290.0).
		(330.0@270.0) corner: (380.0@290.0).
		(440.0@270.0) corner: (490.0@290.0).
		(550.0@270.0) corner: (600.0@290.0).
		(660.0@270.0) corner: (710.0@290.0).
		(770.0@270.0) corner: (820.0@290.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradVerticalTreeLayoutExamples >> simpleTreeWithNodesOfDifferentSizes [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructTreeWithNodesOfDifferentSizes.

	aTreeLayout := self treeLayout.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children measuredBounds equals: {
		(82.0@0.0) corner: (132.0@20.0).
		(0.0@31.0) corner: (40.0@71.0).
		(42.0@31.0) corner: (142.0@131.0).
		(144.0@31.0) corner: (214.0@101.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradVerticalTreeLayoutExamples >> simpleTreeWithNodesOfIncreasingSizeCenterAlignment [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructTreeWithNodesOfIncreasingSize.

	aTreeLayout := self treeLayout.
	aTreeLayout nodesAlignment: GtGradTreeNodesCenterAlignment new.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children measuredBounds equals: {
		(499.5@0.0) corner: (509.5@10.0).
		(175.5@26.0) corner: (195.5@46.0).
		(803.5@21.0) corner: (833.5@51.0).
		(66.0@77.0) corner: (106.0@117.0).
		(255.0@72.0) corner: (305.0@122.0).
		(631.0@67.0) corner: (691.0@127.0).
		(936.0@62.0) corner: (1006.0@132.0).
		(0.0@178.0) corner: (80.0@258.0).
		(82.0@173.0) corner: (172.0@263.0).
		(174.0@168.0) corner: (274.0@268.0).
		(276.0@163.0) corner: (386.0@273.0).
		(388.0@158.0) corner: (508.0@278.0).
		(510.0@153.0) corner: (640.0@283.0).
		(642.0@148.0) corner: (782.0@288.0).
		(784.0@143.0) corner: (934.0@293.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradVerticalTreeLayoutExamples >> simpleTreeWithNodesOfIncreasingSizeLeafAlignment [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructTreeWithNodesOfIncreasingSize.

	aTreeLayout := self treeLayout.
	aTreeLayout nodesAlignment: GtGradTreeNodesLeafAlignment new.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children measuredBounds equals: {
		(499.5@0.0) corner: (509.5@10.0).
		(175.5@31.0) corner: (195.5@51.0).
		(803.5@21.0) corner: (833.5@51.0).
		(66.0@92.0) corner: (106.0@132.0).
		(255.0@82.0) corner: (305.0@132.0).
		(631.0@72.0) corner: (691.0@132.0).
		(936.0@62.0) corner: (1006.0@132.0).
		(0.0@213.0) corner: (80.0@293.0).
		(82.0@203.0) corner: (172.0@293.0).
		(174.0@193.0) corner: (274.0@293.0).
		(276.0@183.0) corner: (386.0@293.0).
		(388.0@173.0) corner: (508.0@293.0).
		(510.0@163.0) corner: (640.0@293.0).
		(642.0@153.0) corner: (782.0@293.0).
		(784.0@143.0) corner: (934.0@293.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradVerticalTreeLayoutExamples >> simpleTreeWithNodesOfIncreasingSizeRootAlignment [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructTreeWithNodesOfIncreasingSize.

	aTreeLayout := self treeLayout.
	aTreeLayout nodesAlignment: GtGradTreeNodesRootAlignment new.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children measuredBounds equals: {
		(499.5@0.0) corner: (509.5@10.0).
		(175.5@21.0) corner: (195.5@41.0).
		(803.5@21.0) corner: (833.5@51.0).
		(66.0@62.0) corner: (106.0@102.0).
		(255.0@62.0) corner: (305.0@112.0).
		(631.0@62.0) corner: (691.0@122.0).
		(936.0@62.0) corner: (1006.0@132.0).
		(0.0@143.0) corner: (80.0@223.0).
		(82.0@143.0) corner: (172.0@233.0).
		(174.0@143.0) corner: (274.0@243.0).
		(276.0@143.0) corner: (386.0@253.0).
		(388.0@143.0) corner: (508.0@263.0).
		(510.0@143.0) corner: (640.0@273.0).
		(642.0@143.0) corner: (782.0@283.0).
		(784.0@143.0) corner: (934.0@293.0)
	}.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradVerticalTreeLayoutExamples >> simpleTreeWithSmallerDistances [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructSimpleTree.

	aTreeLayout := self treeLayout: 5 nodeDistance: 1.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children measuredBounds equals: {
		(201.5@0.0) corner: (251.5@20.0).
		(78.0@26.0) corner: (128.0@46.0).
		(325.0@26.0) corner: (375.0@46.0).
		(26.0@52.0) corner: (76.0@72.0).
		(130.0@52.0) corner: (180.0@72.0).
		(286.0@52.0) corner: (336.0@72.0).
		(364.0@52.0) corner: (414.0@72.0).
		(0.0@78.0) corner: (50.0@98.0).
		(52.0@78.0) corner: (102.0@98.0).
		(104.0@78.0) corner: (154.0@98.0).
		(156.0@78.0) corner: (206.0@98.0).
		(208.0@78.0) corner: (258.0@98.0).
		(260.0@78.0) corner: (310.0@98.0).
		(312.0@78.0) corner: (362.0@98.0).
		(364.0@78.0) corner: (414.0@98.0)
	}.
	
	^ aParentNode
]

{ #category : #'examples - instance creation' }
GtGradVerticalTreeLayoutExamples >> treeLayout [
	<gtExample>
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
