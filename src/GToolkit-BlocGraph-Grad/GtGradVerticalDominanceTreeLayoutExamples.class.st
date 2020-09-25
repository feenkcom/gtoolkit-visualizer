Class {
	#name : #GtGradVerticalDominanceTreeLayoutExamples,
	#superclass : #GtGradDominanceTreeLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'example - layout' }
GtGradVerticalDominanceTreeLayoutExamples >> compactSubtrees [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructTreeWithNodesWithAndWithoutChildrenOnTheSameLevel.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout separateSubtrees: false.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
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

{ #category : #'example - instance creation' }
GtGradVerticalDominanceTreeLayoutExamples >> dominanceTreeLayout [
	<gtExample>
	| aTreeLayout |

	aTreeLayout := GtGradVerticalDominanceTreeLayout new.
	self assert: aTreeLayout levelDistance equals: 10.
	self assert: aTreeLayout nodeDistance equals: 1.

	^ aTreeLayout
]

{ #category : #'example - layout' }
GtGradVerticalDominanceTreeLayoutExamples >> dominanceTreeWithMultiplePathsToANodesWith8Nodes [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructDominanceTreeWithMultiplePathsToANodesWith8Nodes.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
		(26.0@0.0) corner: (76.0@20.0).
		(0.0@31.0) corner: (50.0@51.0).
		(52.0@31.0) corner: (102.0@51.0).
		(52.0@62.0) corner: (102.0@82.0).
		(52.0@93.0) corner: (102.0@113.0).
		(52.0@124.0) corner: (102.0@144.0).
		(52.0@155.0) corner: (102.0@175.0).
		(52.0@186.0) corner: (102.0@206.0)
	}.

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradVerticalDominanceTreeLayoutExamples >> dominanceTreeWithMultiplePathsToANodesWith9Nodes [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructDominanceTreeWithMultiplePathsToANodesWith9Nodes.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
		(65.0@0.0) corner: (115.0@20.0).
		(26.0@31.0) corner: (76.0@51.0).
		(104.0@31.0) corner: (154.0@51.0).
		(0.0@62.0) corner: (50.0@82.0).
		(104.0@62.0) corner: (154.0@82.0).
		(104.0@93.0) corner: (154.0@113.0).
		(104.0@124.0) corner: (154.0@144.0).
		(104.0@155.0) corner: (154.0@175.0).
		(52.0@62.0) corner: (102.0@82.0)
	}.
	
	^ aParentNode
]

{ #category : #'example - layout' }
GtGradVerticalDominanceTreeLayoutExamples >> graphWithANodeWithSeveralIncomingEdges [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructGraphWithANodeWithSeveralIncomingEdges.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
		(78.0@0.0) corner: (128.0@20.0).
		(0.0@31.0) corner: (50.0@51.0).
		(52.0@31.0) corner: (102.0@51.0).
		(104.0@31.0) corner: (154.0@51.0).
		(156.0@31.0) corner: (206.0@51.0).
		(0.0@62.0) corner: (50.0@82.0)
	}.

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradVerticalDominanceTreeLayoutExamples >> separatedSubtrees [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructTreeWithNodesWithAndWithoutChildrenOnTheSameLevel.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout separateSubtrees: true.
	aTreeLayout measure: aParentNode.

	self assert: aParentNode children layoutBounds equals: {
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

{ #category : #'example - layout' }
GtGradVerticalDominanceTreeLayoutExamples >> simpleDominanceTreeWith5Nodes [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructDominanceTreeWith5Nodes.

	aTreeLayout := self dominanceTreeLayout.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
		(26.0@0.0) corner: (76.0@20.0).
		(0.0@31.0) corner: (50.0@51.0).
		(52.0@31.0) corner: (102.0@51.0).
		(52.0@62.0) corner: (102.0@82.0).
		(52.0@93.0) corner: (102.0@113.0)
	}.

	^ aParentNode
]
