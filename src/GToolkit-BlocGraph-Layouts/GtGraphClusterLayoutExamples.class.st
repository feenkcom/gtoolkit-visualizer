Class {
	#name : #GtGraphClusterLayoutExamples,
	#superclass : #GtGraphLayoutExamples,
	#category : #'GToolkit-BlocGraph-Layouts-Examples'
}

{ #category : #example }
GtGraphClusterLayoutExamples >> forestOfClusters [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self
			createGraph: 20
			extent: 10 @ 10
			pairs: ((1 to: 20) collect: [ :x | x // 3 -> x ]).

	aLayout := GtGraphClusterLayout new.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {87 @ 60 corner: 97 @ 70.
				96 @ 119 corner: 106 @ 129.
				146 @ 71 corner: 156 @ 81.
				84 @ 30 corner: 94 @ 40.
				30 @ 80 corner: 40 @ 90.
				65 @ 145 corner: 75 @ 155.
				138 @ 165 corner: 148 @ 175.
				160 @ 145 corner: 170 @ 155.
				179 @ 90 corner: 189 @ 100.
				174 @ 61 corner: 184 @ 71.
				160 @ 35 corner: 170 @ 45.
				111 @ 3 corner: 121 @ 13.
				82 @ 0 corner: 92 @ 10.
				53 @ 8 corner: 63 @ 18.
				10 @ 47 corner: 20 @ 57.
				0 @ 75 corner: 10 @ 85.
				0 @ 105 corner: 10 @ 115.
				28 @ 156 corner: 38 @ 166.
				53 @ 172 corner: 63 @ 182.
				82 @ 180 corner: 92 @ 190}.

	^ aParentNode
]
