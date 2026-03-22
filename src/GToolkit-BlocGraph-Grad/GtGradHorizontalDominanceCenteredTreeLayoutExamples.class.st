Class {
	#name : #GtGradHorizontalDominanceCenteredTreeLayoutExamples,
	#superclass : #GtGradDominanceCenteredTreeLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'example - instance creation' }
GtGradHorizontalDominanceCenteredTreeLayoutExamples >> centeredDominanceTreeLayout [
	|  aTreeLayout |

	aTreeLayout := GtGradHorizontalDominanceCenteredTreeLayout new.
	self assert: aTreeLayout levelDistance equals: 10.
	self assert: aTreeLayout nodeDistance equals: 1.

	^ aTreeLayout
]

{ #category : #'example - layout' }
GtGradHorizontalDominanceCenteredTreeLayoutExamples >> complicatedExampleToCheckOverlap [
	<gtExample>
	<NoTest>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout bounds |
	aParentNode := self
			createGraph: 15
			pairs: {1 -> 2.
					1 -> 3.
					1 -> 4.
					1 -> 5.
					2 -> 6.
					3 -> 6.
					4 -> 6.
					5 -> 6.
					5 -> 12.
					6 -> 7.
					6 -> 8.
					2 -> 10.
					10 -> 11.
					11 -> 9.
					7 -> 9.
					8 -> 9.
					12 -> 13.
					12 -> 14.
					12 -> 15}.

	aTreeLayout := self centeredDominanceTreeLayout.
	aTreeLayout measure: aParentNode.
	bounds := aParentNode children layoutBounds.	"self
		assert: (bounds
				anySatisfy: [ :rect1 | bounds anySatisfy: [ :rect2 | rect1 ~~ rect2 and: [ rect1 intersects: rect2 ] ] ])
				not."

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradHorizontalDominanceCenteredTreeLayoutExamples >> graphWithANodeWithSeveralIncomingEdges [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructGraphWithANodeWithSeveralIncomingEdges.

	aTreeLayout := self centeredDominanceTreeLayout.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {0.0 @ 33.0 corner: 50.0 @ 53.0.
				61.0 @ 0.0 corner: 111.0 @ 20.0.
				61.0 @ 22.0 corner: 111.0 @ 42.0.
				61.0 @ 44.0 corner: 111.0 @ 64.0.
				61.0 @ 66.0 corner: 111.0 @ 86.0.
				122.0 @ 22.0 corner: 172.0 @ 42.0}.

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradHorizontalDominanceCenteredTreeLayoutExamples >> graphWithANodeWithSeveralIncomingEdgesScaled [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructGraphWithANodeWithSeveralIncomingEdgesScaled.

	aTreeLayout := self centeredDominanceTreeLayout.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {0.0 @ 43.0 corner: 50.0 @ 63.0.
				61.0 @ 0.0 corner: 111.0 @ 20.0.
				61.0 @ 22.0 corner: 111.0 @ 42.0.
				86.0 @ 54.0 corner: 136.0 @ 74.0.
				61.0 @ 86.0 corner: 111.0 @ 106.0.
				172.0 @ 22.0 corner: 222.0 @ 42.0}.

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradHorizontalDominanceCenteredTreeLayoutExamples >> moreComplexGraphWithANodeWithSeveralIncomingEdges [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructMoreComplexGraphWithANodeWithSeveralIncomingEdges.

	aTreeLayout := self centeredDominanceTreeLayout.
	aTreeLayout measure: aParentNode.	"self assert: aParentNode children layoutBounds equals: {
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
	}."

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradHorizontalDominanceCenteredTreeLayoutExamples >> simpleExampleToCheckOverlap [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout bounds |
	aParentNode := self
			createGraph: 12
			pairs: {1 -> 2.
					1 -> 3.
					1 -> 12.
					2 -> 4.
					4 -> 6.
					4 -> 7.
					4 -> 8.
					12 -> 5.
					5 -> 9.
					5 -> 10.
					5 -> 11}.

	aTreeLayout := self centeredDominanceTreeLayout.
	aTreeLayout measure: aParentNode.
	bounds := aParentNode children layoutBounds.
	self
		assert: (bounds
				anySatisfy: [ :rect1 | bounds anySatisfy: [ :rect2 | rect1 ~~ rect2 and: [ rect1 intersects: rect2 ] ] ])
				not.

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradHorizontalDominanceCenteredTreeLayoutExamples >> treeWithEdgesWhoseSoucesAreOnDifferentLevels [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructTreeWithEdgesWhoseSourcesAreOnDifferentLevels.

	aTreeLayout := self centeredDominanceTreeLayout.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {0.0 @ 22.0 corner: 50.0 @ 42.0.
				61.0 @ 0.0 corner: 111.0 @ 20.0.
				61.0 @ 22.0 corner: 111.0 @ 42.0.
				61.0 @ 44.0 corner: 111.0 @ 64.0.
				122.0 @ 0.0 corner: 172.0 @ 20.0.
				183.0 @ 0.0 corner: 233.0 @ 20.0}.

	^ aParentNode
]
