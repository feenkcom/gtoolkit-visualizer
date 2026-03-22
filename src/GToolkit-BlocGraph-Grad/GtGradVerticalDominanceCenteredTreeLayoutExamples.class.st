Class {
	#name : #GtGradVerticalDominanceCenteredTreeLayoutExamples,
	#superclass : #GtGradDominanceCenteredTreeLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'example - instance creation' }
GtGradVerticalDominanceCenteredTreeLayoutExamples >> centeredDominanceTreeLayout [
	<gtExample>
	<return: #GtGradVerticalDominanceCenteredTreeLayout>
	| aTreeLayout |
	aTreeLayout := GtGradVerticalDominanceCenteredTreeLayout new.
	self assert: aTreeLayout levelDistance equals: 10.
	self assert: aTreeLayout nodeDistance equals: 1.

	^ aTreeLayout
]

{ #category : #'example - layout' }
GtGradVerticalDominanceCenteredTreeLayoutExamples >> graphWithANodeWithSeveralIncomingEdges [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructGraphWithANodeWithSeveralIncomingEdges.

	aTreeLayout := self centeredDominanceTreeLayout.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {78.0 @ 0.0 corner: 128.0 @ 20.0.
				0.0 @ 31.0 corner: 50.0 @ 51.0.
				52.0 @ 31.0 corner: 102.0 @ 51.0.
				104.0 @ 31.0 corner: 154.0 @ 51.0.
				156.0 @ 31.0 corner: 206.0 @ 51.0.
				52.0 @ 62.0 corner: 102.0 @ 82.0}.

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradVerticalDominanceCenteredTreeLayoutExamples >> moreComplexGraphWithANodeWithSeveralIncomingEdges [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructMoreComplexGraphWithANodeWithSeveralIncomingEdges.

	aTreeLayout := self centeredDominanceTreeLayout.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {91.0 @ 0.0 corner: 141.0 @ 20.0.
				0.0 @ 31.0 corner: 50.0 @ 51.0.
				78.0 @ 31.0 corner: 128.0 @ 51.0.
				130.0 @ 31.0 corner: 180.0 @ 51.0.
				182.0 @ 31.0 corner: 232.0 @ 51.0.
				78.0 @ 62.0 corner: 128.0 @ 82.0.
				52.0 @ 93.0 corner: 102.0 @ 113.0.
				104.0 @ 93.0 corner: 154.0 @ 113.0.
				52.0 @ 124.0 corner: 102.0 @ 144.0.
				0.0 @ 62.0 corner: 50.0 @ 82.0.
				0.0 @ 93.0 corner: 50.0 @ 113.0}.

	^ aParentNode
]

{ #category : #'example - layout' }
GtGradVerticalDominanceCenteredTreeLayoutExamples >> treeWithEdgesWhoseSoucesAreOnDifferentLevels [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aTreeLayout |
	aParentNode := self constructTreeWithEdgesWhoseSourcesAreOnDifferentLevels.

	aTreeLayout := self centeredDominanceTreeLayout.
	aTreeLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {52.0 @ 0.0 corner: 102.0 @ 20.0.
				0.0 @ 31.0 corner: 50.0 @ 51.0.
				52.0 @ 31.0 corner: 102.0 @ 51.0.
				104.0 @ 31.0 corner: 154.0 @ 51.0.
				0.0 @ 62.0 corner: 50.0 @ 82.0.
				0.0 @ 93.0 corner: 50.0 @ 113.0}.

	^ aParentNode
]
