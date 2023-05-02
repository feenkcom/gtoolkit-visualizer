Class {
	#name : #GtGradHorizontalDominanceTreeLayoutExamples,
	#superclass : #GtGradDominanceTreeLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'example - layout' }
GtGradHorizontalDominanceTreeLayoutExamples >> compactSubtrees [
	<gtExample>
	<noTest>
	| aParentNode aTreeLayout |

	aParentNode := self constructTreeWithNodesWithAndWithoutChildrenOnTheSameLevel.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout separateSubtrees: false.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
		(0.0@46.0) corner: (50.0@66.0).
		(61.0@22.0) corner: (111.0@42.0).
		(61.0@48.0) corner: (111.0@68.0).
		(61.0@70.0) corner: (111.0@90.0).
		(122.0@0.0) corner: (172.0@20.0).
		(122.0@22.0) corner: (172.0@42.0).
		(122.0@44.0) corner: (172.0@64.0)
	}.

	^ aParentNode
]

{ #category : #'example - instance creation' }
GtGradHorizontalDominanceTreeLayoutExamples >> dominanceTreeLayout [
	<gtExample>
	| aTreeLayout |

	aTreeLayout := GtGradHorizontalDominanceTreeLayout new.
	self assert: aTreeLayout levelDistance equals: 10.
	self assert: aTreeLayout nodeDistance equals: 1.

	^ aTreeLayout
]

{ #category : #'example - layout' }
GtGradHorizontalDominanceTreeLayoutExamples >> dominanceTreeWithMultiplePathsToANodesWith8Nodes [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructDominanceTreeWithMultiplePathsToANodesWith8Nodes.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
		(0.0@11.0) corner: (50.0@31.0).
		(61.0@0.0) corner: (111.0@20.0).
		(61.0@22.0) corner: (111.0@42.0).
		(122.0@22.0) corner: (172.0@42.0).
		(183.0@22.0) corner: (233.0@42.0).
		(244.0@22.0) corner: (294.0@42.0).
		(305.0@22.0) corner: (355.0@42.0).
		(366.0@22.0) corner: (416.0@42.0)
	}.

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradHorizontalDominanceTreeLayoutExamples >> dominanceTreeWithMultiplePathsToANodesWith9Nodes [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructDominanceTreeWithMultiplePathsToANodesWith9Nodes.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
		(0.0@27.5) corner: (50.0@47.5).
		(61.0@11.0) corner: (111.0@31.0).
		(61.0@44.0) corner: (111.0@64.0).
		(122.0@0.0) corner: (172.0@20.0).
		(122.0@44.0) corner: (172.0@64.0).
		(183.0@44.0) corner: (233.0@64.0).
		(244.0@44.0) corner: (294.0@64.0).
		(305.0@44.0) corner: (355.0@64.0).
		(122.0@22.0) corner: (172.0@42.0)
	}.
	
	^ aParentNode
]

{ #category : #'example - layout' }
GtGradHorizontalDominanceTreeLayoutExamples >> graphWithANodeWithSeveralIncomingEdges [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructGraphWithANodeWithSeveralIncomingEdges.

	aTreeLayout := self dominanceTreeLayout.
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

{ #category : #'example - layout' }
GtGradHorizontalDominanceTreeLayoutExamples >> separatedSubtrees [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructTreeWithNodesWithAndWithoutChildrenOnTheSameLevel.

	aTreeLayout := self dominanceTreeLayout.
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

{ #category : #'example - layout' }
GtGradHorizontalDominanceTreeLayoutExamples >> simpleDominanceTreeWith5Nodes [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructDominanceTreeWith5Nodes.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
		(0.0@11.0) corner: (50.0@31.0).
		(61.0@0.0) corner: (111.0@20.0).
		(61.0@22.0) corner: (111.0@42.0).
		(122.0@22.0) corner: (172.0@42.0).
		(183.0@22.0) corner: (233.0@42.0)
	}.

	^ aParentNode
]
