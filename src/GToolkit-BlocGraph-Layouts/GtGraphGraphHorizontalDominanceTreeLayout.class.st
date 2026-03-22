Class {
	#name : #GtGraphGraphHorizontalDominanceTreeLayout,
	#superclass : #GtGraphLayoutExamples,
	#category : #'GToolkit-BlocGraph-Layouts-Examples'
}

{ #category : #public }
GtGraphGraphHorizontalDominanceTreeLayout >> binaryTree [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self
			createGraph: 15
			extent: 10 @ 10
			pairs: ((1 to: 15) collect: [ :x | x // 2 -> x ]).

	aLayout := GtGraphHorizontalDominanceTreeLayout new.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {0 @ 46 corner: 10 @ 56.
				30 @ 20 corner: 40 @ 30.
				30 @ 72 corner: 40 @ 82.
				60 @ 7 corner: 70 @ 17.
				60 @ 33 corner: 70 @ 43.
				60 @ 59 corner: 70 @ 69.
				60 @ 85 corner: 70 @ 95.
				90 @ 0 corner: 100 @ 10.
				90 @ 13 corner: 100 @ 23.
				90 @ 26 corner: 100 @ 36.
				90 @ 39 corner: 100 @ 49.
				90 @ 52 corner: 100 @ 62.
				90 @ 65 corner: 100 @ 75.
				90 @ 78 corner: 100 @ 88.
				90 @ 91 corner: 100 @ 101}.

	^ aParentNode
]
