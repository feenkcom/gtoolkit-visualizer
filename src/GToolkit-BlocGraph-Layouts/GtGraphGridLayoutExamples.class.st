Class {
	#name : #GtGraphGridLayoutExamples,
	#superclass : #GtGraphLayoutExamples,
	#category : #'GToolkit-BlocGraph-Layouts-Examples'
}

{ #category : #example }
GtGraphGridLayoutExamples >> squareOfSquares [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createNodes: 16 extent: 20 @ 20.

	aLayout := GtGraphGridLayout new.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {0 @ 0 corner: 20 @ 20.
				25 @ 0 corner: 45 @ 20.
				50 @ 0 corner: 70 @ 20.
				75 @ 0 corner: 95 @ 20.
				0 @ 25 corner: 20 @ 45.
				25 @ 25 corner: 45 @ 45.
				50 @ 25 corner: 70 @ 45.
				75 @ 25 corner: 95 @ 45.
				0 @ 50 corner: 20 @ 70.
				25 @ 50 corner: 45 @ 70.
				50 @ 50 corner: 70 @ 70.
				75 @ 50 corner: 95 @ 70.
				0 @ 75 corner: 20 @ 95.
				25 @ 75 corner: 45 @ 95.
				50 @ 75 corner: 70 @ 95.
				75 @ 75 corner: 95 @ 95}.

	^ aParentNode
]
