Class {
	#name : #GtGradHorizontalDominanceCenteredTreeLayoutExamples,
	#superclass : #GtGradDominanceCenteredTreeLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'example - instance creation' }
GtGradHorizontalDominanceCenteredTreeLayoutExamples >> centeredDominanceTreeLayout [
	<gtExample>
	|  aTreeLayout |

	aTreeLayout := GtGradHorizontalDominanceCenteredTreeLayout new.
	self assert: aTreeLayout levelDistance equals: 10.
	self assert: aTreeLayout nodeDistance equals: 1.

	^ aTreeLayout
]

{ #category : #'example - layout' }
GtGradHorizontalDominanceCenteredTreeLayoutExamples >> graphWithANodeWithSeveralIncomingEdges [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructGraphWithANodeWithSeveralIncomingEdges.

	aTreeLayout := self centeredDominanceTreeLayout.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
		(0.0@33.0) corner: (50.0@53.0).
		(61.0@0.0) corner: (111.0@20.0).
		(61.0@22.0) corner: (111.0@42.0).
		(61.0@44.0) corner: (111.0@64.0).
		(61.0@66.0) corner: (111.0@86.0).
		(122.0@22.0) corner: (172.0@42.0)
	}.

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradHorizontalDominanceCenteredTreeLayoutExamples >> graphWithANodeWithSeveralIncomingEdgesScaled [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructGraphWithANodeWithSeveralIncomingEdgesScaled.

	aTreeLayout := self centeredDominanceTreeLayout.
	aTreeLayout measure: aParentNode.
	
	"self assert: aParentNode children layoutBounds equals: {
		(25.0@73.0) corner: (75.0@93.0).
		(136.0@10.0) corner: (186.0@30.0).
		(136.0@52.0) corner: (186.0@72.0).
		(136.0@94.0) corner: (186.0@114.0).
		(136.0@136.0) corner: (186.0@156.0).
		(247.0@52.0) corner: (297.0@72.0)
	}."

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradHorizontalDominanceCenteredTreeLayoutExamples >> moreComplexGraphWithANodeWithSeveralIncomingEdges [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructMoreComplexGraphWithANodeWithSeveralIncomingEdges.

	aTreeLayout := self centeredDominanceTreeLayout.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
		(0.0@38.5) corner: (50.0@58.5).
		(61.0@0.0) corner: (111.0@20.0).
		(61.0@33.0) corner: (111.0@53.0).
		(61.0@55.0) corner: (111.0@75.0).
		(61.0@77.0) corner: (111.0@97.0).
		(122.0@33.0) corner: (172.0@53.0).
		(183.0@22.0) corner: (233.0@42.0).
		(183.0@44.0) corner: (233.0@64.0).
		(244.0@22.0) corner: (294.0@42.0).
		(122.0@0.0) corner: (172.0@20.0).
		(183.0@0.0) corner: (233.0@20.0)
	}.
	
	^ aParentNode
]

{ #category : #'example - layout' }
GtGradHorizontalDominanceCenteredTreeLayoutExamples >> treeWithEdgesWhoseSoucesAreOnDifferentLevels [
	<gtExample>
	| aParentNode aTreeLayout |

	aParentNode := self constructTreeWithEdgesWhoseSourcesAreOnDifferentLevels.

	aTreeLayout := self centeredDominanceTreeLayout.
	aTreeLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
		(0.0@22.0) corner: (50.0@42.0).
		(61.0@0.0) corner: (111.0@20.0).
		(61.0@22.0) corner: (111.0@42.0).
		(61.0@44.0) corner: (111.0@64.0).
		(122.0@0.0) corner: (172.0@20.0).
		(183.0@0.0) corner: (233.0@20.0)
	}.

	^ aParentNode
]
