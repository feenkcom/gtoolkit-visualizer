Class {
	#name : #GtGradHierarchicalTreeLayoutExamples,
	#superclass : #GtGradLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'examples - instance creation' }
GtGradHierarchicalTreeLayoutExamples >> createGraphForHierarchical [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	^ self
		createGraph: 6
		pairs: {1 -> 2.
				1 -> 3.
				2 -> 4.
				3 -> 5.
				4 -> 3.
				4 -> 6.
				5 -> 6.
				5 -> 2.
				6 -> 1}
]

{ #category : #'examples - instance creation' }
GtGradHierarchicalTreeLayoutExamples >> createGraphForHierarchicalTree [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	^ self
		createGraph: 7
		pairs: {1 -> 2.
				1 -> 3.
				2 -> 4.
				2 -> 5.
				3 -> 6.
				3 -> 7.
				5 -> 3.
				6 -> 2}
]

{ #category : #'examples - hierarchical' }
GtGradHierarchicalTreeLayoutExamples >> eastHierarchical [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createGraphForHierarchical.

	aLayout := GtGradEastHierarchicalTreeLayout new.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {400 @ 40 corner: 450 @ 60.
				320 @ 20 corner: 370 @ 40.
				160 @ 0 corner: 210 @ 20.
				240 @ 0 corner: 290 @ 20.
				80 @ 10 corner: 130 @ 30.
				0 @ 10 corner: 50 @ 30}.

	self assert: (aLayout layout isMemberOf: GtGradEastHierarchicalLayout).
	self assert: aLayout layout intraRankSpacing equals: aLayout nodesDistance.
	self assert: aLayout layout interRanksSpacing equals: aLayout levelDistance.
	self
		assert: aLayout layout interHierarchySpacing
		equals: aLayout componentsDistance.
	self
		assert: (aLayout layout alignment isMemberOf: GtGradHierarchicalLayoutCenterAlignment).

	^ aParentNode
]

{ #category : #'examples - tree' }
GtGradHierarchicalTreeLayoutExamples >> eastTree [
	<gtExample>
	<noTest>
	| aParentNode aLayout |

	aParentNode := self createGraphForHierarchicalTree.
	
	aLayout := GtGradEastHierarchicalTreeLayout new.
	aLayout measure: aParentNode.

	self assert: aParentNode children layoutBounds equals: {
		(360.0@30.0) corner: (410.0@50.0).
		(270.0@30.0) corner: (320.0@50.0).
		(90.0@40.0) corner: (140.0@60.0).
		(180.0@0.0) corner: (230.0@20.0).
		(180.0@40.0) corner: (230.0@60.0).
		(0.0@20.0) corner: (50.0@40.0).
		(0.0@60.0) corner: (50.0@80.0)
	}.

	self
		assert: (aLayout layout isKindOf: GtGradHorizontalDominanceTreeLayout).
	self assert: aLayout layout reverse.
	self
		assert: aLayout layout nodeDistance
		equals: aLayout nodesDistance.
	self
		assert: aLayout layout levelDistance
		equals: aLayout levelDistance.
	self
		assert: aLayout layout treesDistance
		equals: aLayout componentsDistance.
	self
		assert: (aLayout layout nodesAlignment isMemberOf: GtGradTreeNodesCenterAlignment).

	^ aParentNode
]

{ #category : #'examples - hierarchical' }
GtGradHierarchicalTreeLayoutExamples >> northHierarchical [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createGraphForHierarchical.

	aLayout := GtGradNorthHierarchicalTreeLayout new.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {70 @ 0 corner: 120 @ 20.
				35 @ 50 corner: 85 @ 70.
				0 @ 150 corner: 50 @ 170.
				0 @ 100 corner: 50 @ 120.
				18 @ 200 corner: 68 @ 220.
				18 @ 250 corner: 68 @ 270}.

	self assert: (aLayout layout isMemberOf: GtGradNorthHierarchicalLayout).
	self assert: aLayout layout intraRankSpacing equals: aLayout nodesDistance.
	self assert: aLayout layout interRanksSpacing equals: aLayout levelDistance.
	self
		assert: aLayout layout interHierarchySpacing
		equals: aLayout componentsDistance.
	self
		assert: (aLayout layout alignment isMemberOf: GtGradHierarchicalLayoutCenterAlignment).

	^ aParentNode
]

{ #category : #'examples - tree' }
GtGradHierarchicalTreeLayoutExamples >> northTree [
	<gtExample>
		<noTest>
	| aParentNode aLayout |

	aParentNode := self createGraphForHierarchicalTree.
	
	aLayout := GtGradNorthHierarchicalTreeLayout new.
	aLayout measure: aParentNode.

	self assert: aParentNode children layoutBounds equals: {
		(35.0@0.0) corner: (85.0@20.0).
		(35.0@60.0) corner: (85.0@80.0).
		(70.0@180.0) corner: (120.0@200.0).
		(0.0@120.0) corner: (50.0@140.0).
		(70.0@120.0) corner: (120.0@140.0).
		(35.0@240.0) corner: (85.0@260.0).
		(105.0@240.0) corner: (155.0@260.0)
	}.

	self
		assert: (aLayout layout isKindOf: GtGradVerticalDominanceTreeLayout).
	self assert: aLayout layout reverse not.
	self
		assert: aLayout layout nodeDistance
		equals: aLayout nodesDistance.
	self
		assert: aLayout layout levelDistance
		equals: aLayout levelDistance.
	self
		assert: aLayout layout treesDistance
		equals: aLayout componentsDistance.
	self
		assert: (aLayout layout nodesAlignment isMemberOf: GtGradTreeNodesCenterAlignment).
	
	^ aParentNode
]

{ #category : #'examples - hierarchical' }
GtGradHierarchicalTreeLayoutExamples >> southHierarchical [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createGraphForHierarchical.

	aLayout := GtGradSouthHierarchicalTreeLayout new.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {70 @ 250 corner: 120 @ 270.
				35 @ 200 corner: 85 @ 220.
				0 @ 100 corner: 50 @ 120.
				0 @ 150 corner: 50 @ 170.
				18 @ 50 corner: 68 @ 70.
				18 @ 0 corner: 68 @ 20}.

	self assert: (aLayout layout isMemberOf: GtGradSouthHierarchicalLayout).
	self assert: aLayout layout intraRankSpacing equals: aLayout nodesDistance.
	self assert: aLayout layout interRanksSpacing equals: aLayout levelDistance.
	self
		assert: aLayout layout interHierarchySpacing
		equals: aLayout componentsDistance.
	self
		assert: (aLayout layout alignment isMemberOf: GtGradHierarchicalLayoutCenterAlignment).

	^ aParentNode
]

{ #category : #'examples - tree' }
GtGradHierarchicalTreeLayoutExamples >> southTree [
	<gtExample>
		<noTest>
	| aParentNode aLayout |

	aParentNode := self createGraphForHierarchicalTree.
	
	aLayout := GtGradSouthHierarchicalTreeLayout new.
	aLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
		(35.0@240.0) corner: (85.0@260.0).
		(35.0@180.0) corner: (85.0@200.0).
		(70.0@60.0) corner: (120.0@80.0).
		(0.0@120.0) corner: (50.0@140.0).
		(70.0@120.0) corner: (120.0@140.0).
		(35.0@0.0) corner: (85.0@20.0).
		(105.0@0.0) corner: (155.0@20.0)
	}.
	
	self
		assert: (aLayout layout isKindOf: GtGradVerticalDominanceTreeLayout).
	self assert: aLayout layout reverse.
	self
		assert: aLayout layout nodeDistance
		equals: aLayout nodesDistance.
	self
		assert: aLayout layout levelDistance
		equals: aLayout levelDistance.
	self
		assert: aLayout layout treesDistance
		equals: aLayout componentsDistance.
	self
		assert: (aLayout layout nodesAlignment isMemberOf: GtGradTreeNodesCenterAlignment).

	^ aParentNode
]

{ #category : #'examples - hierarchical' }
GtGradHierarchicalTreeLayoutExamples >> westHierarchical [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createGraphForHierarchical.

	aLayout := GtGradWestHierarchicalTreeLayout new.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {0 @ 40 corner: 50 @ 60.
				80 @ 20 corner: 130 @ 40.
				240 @ 0 corner: 290 @ 20.
				160 @ 0 corner: 210 @ 20.
				320 @ 10 corner: 370 @ 30.
				400 @ 10 corner: 450 @ 30}.

	self assert: (aLayout layout isMemberOf: GtGradWestHierarchicalLayout).
	self assert: aLayout layout intraRankSpacing equals: aLayout nodesDistance.
	self assert: aLayout layout interRanksSpacing equals: aLayout levelDistance.
	self
		assert: aLayout layout interHierarchySpacing
		equals: aLayout componentsDistance.
	self
		assert: (aLayout layout alignment isMemberOf: GtGradHierarchicalLayoutCenterAlignment).

	^ aParentNode
]

{ #category : #'examples - tree' }
GtGradHierarchicalTreeLayoutExamples >> westTree [
	<gtExample>
	<noTest>
	| aParentNode aLayout |

	aParentNode := self createGraphForHierarchicalTree.
	
	aLayout := GtGradWestHierarchicalTreeLayout new.
	aLayout measure: aParentNode.
	
	"self assert: aParentNode children layoutBounds equals: {
		(0.0@20.0) corner: (50.0@40.0).
		(90.0@20.0) corner: (140.0@40.0).
		(270.0@40.0) corner: (320.0@60.0).
		(180.0@0.0) corner: (230.0@20.0).
		(180.0@40.0) corner: (230.0@60.0).
		(360.0@20.0) corner: (410.0@40.0).
		(360.0@60.0) corner: (410.0@80.0)
	}."
	
	self
		assert: (aLayout layout isKindOf: GtGradHorizontalDominanceTreeLayout).
	self assert: aLayout layout reverse not.
	self
		assert: aLayout layout nodeDistance
		equals: aLayout nodesDistance.
	self
		assert: aLayout layout levelDistance
		equals: aLayout levelDistance.
	self
		assert: aLayout layout treesDistance
		equals: aLayout componentsDistance.
	self
		assert: (aLayout layout nodesAlignment isMemberOf: GtGradTreeNodesCenterAlignment).
	
	^ aParentNode
]
