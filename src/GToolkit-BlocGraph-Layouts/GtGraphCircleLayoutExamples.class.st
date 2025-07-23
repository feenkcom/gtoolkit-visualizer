Class {
	#name : #GtGraphCircleLayoutExamples,
	#superclass : #GtGraphLayoutExamples,
	#category : #'GToolkit-BlocGraph-Layouts-Examples'
}

{ #category : #example }
GtGraphCircleLayoutExamples >> rectangularNodes [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createNodes: 20 extent: 30 @ 15.

	aLayout := GtGraphCircleLayout new radius: 120.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {240 @ 120 corner: 270 @ 135.
				234 @ 157 corner: 264 @ 172.
				217 @ 191 corner: 247 @ 206.
				191 @ 217 corner: 221 @ 232.
				157 @ 234 corner: 187 @ 249.
				120 @ 240 corner: 150 @ 255.
				83 @ 234 corner: 113 @ 249.
				49 @ 217 corner: 79 @ 232.
				23 @ 191 corner: 53 @ 206.
				6 @ 157 corner: 36 @ 172.
				0 @ 120 corner: 30 @ 135.
				6 @ 83 corner: 36 @ 98.
				23 @ 49 corner: 53 @ 64.
				49 @ 23 corner: 79 @ 38.
				83 @ 6 corner: 113 @ 21.
				120 @ 0 corner: 150 @ 15.
				157 @ 6 corner: 187 @ 21.
				191 @ 23 corner: 221 @ 38.
				217 @ 49 corner: 247 @ 64.
				234 @ 83 corner: 264 @ 98}.

	^ aParentNode
]

{ #category : #example }
GtGraphCircleLayoutExamples >> squaredNodes [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createNodes: 20 extent: 20 @ 20.

	aLayout := GtGraphCircleLayout new radius: 100.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {200 @ 100 corner: 220 @ 120.
				195 @ 131 corner: 215 @ 151.
				181 @ 159 corner: 201 @ 179.
				159 @ 181 corner: 179 @ 201.
				131 @ 195 corner: 151 @ 215.
				100 @ 200 corner: 120 @ 220.
				69 @ 195 corner: 89 @ 215.
				41 @ 181 corner: 61 @ 201.
				19 @ 159 corner: 39 @ 179.
				5 @ 131 corner: 25 @ 151.
				0 @ 100 corner: 20 @ 120.
				5 @ 69 corner: 25 @ 89.
				19 @ 41 corner: 39 @ 61.
				41 @ 19 corner: 61 @ 39.
				69 @ 5 corner: 89 @ 25.
				100 @ 0 corner: 120 @ 20.
				131 @ 5 corner: 151 @ 25.
				159 @ 19 corner: 179 @ 39.
				181 @ 41 corner: 201 @ 61.
				195 @ 69 corner: 215 @ 89}.

	^ aParentNode
]
