Class {
	#name : #GtGraphRadialTreeLayoutExamples,
	#superclass : #GtGraphLayoutExamples,
	#category : #'GToolkit-BlocGraph-Layouts-Examples'
}

{ #category : #public }
GtGraphRadialTreeLayoutExamples >> binaryTree [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self
			createGraph: 15
			extent: 10 @ 10
			pairs: ((1 to: 15) collect: [ :x | x // 2 -> x ]).

	aLayout := GtGraphRadialTreeLayout new.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: {48 @ 0 corner: 58 @ 10.
				66 @ 10 corner: 76 @ 20.
				40 @ 18 corner: 50 @ 28.
				88 @ 5 corner: 98 @ 15.
				74 @ 31 corner: 84 @ 41.
				46 @ 40 corner: 56 @ 50.
				19 @ 28 corner: 29 @ 38.
				108 @ 0 corner: 118 @ 10.
				106 @ 15 corner: 116 @ 25.
				92 @ 41 corner: 102 @ 51.
				80 @ 50 corner: 90 @ 60.
				52 @ 60 corner: 62 @ 70.
				37 @ 59 corner: 47 @ 69.
				10 @ 47 corner: 20 @ 57.
				0 @ 36 corner: 10 @ 46}.

	^ aParentNode
]
