Class {
	#name : #GtGraphDominanceTreeLayoutExamples,
	#superclass : #GtGraphLayoutExamples,
	#category : #'GToolkit-BlocGraph-Layouts-Examples'
}

{ #category : #public }
GtGraphDominanceTreeLayoutExamples >> binaryTree [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self
			createGraph: 15
			extent: 10 @ 10
			pairs: ((1 to: 15) collect: [ :x | x // 2 -> x ]).

	aLayout := GtGraphDominanceTreeLayout new.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {46 @ 0 corner: 56 @ 10.
				20 @ 30 corner: 30 @ 40.
				72 @ 30 corner: 82 @ 40.
				7 @ 60 corner: 17 @ 70.
				33 @ 60 corner: 43 @ 70.
				59 @ 60 corner: 69 @ 70.
				85 @ 60 corner: 95 @ 70.
				0 @ 90 corner: 10 @ 100.
				13 @ 90 corner: 23 @ 100.
				26 @ 90 corner: 36 @ 100.
				39 @ 90 corner: 49 @ 100.
				52 @ 90 corner: 62 @ 100.
				65 @ 90 corner: 75 @ 100.
				78 @ 90 corner: 88 @ 100.
				91 @ 90 corner: 101 @ 100}.

	^ aParentNode
]
