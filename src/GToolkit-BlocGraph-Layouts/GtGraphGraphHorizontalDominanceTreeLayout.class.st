Class {
	#name : #GtGraphGraphHorizontalDominanceTreeLayout,
	#superclass : #GtGraphLayoutExamples,
	#category : #'GToolkit-BlocGraph-Layouts-Examples'
}

{ #category : #public }
GtGraphGraphHorizontalDominanceTreeLayout >> binaryTree [
	<gtExample>
	| aParentNode aLayout |

	aParentNode := self
		createGraph: 15
		extent: 10@10
		pairs: ((1 to: 15) collect: [ :x |  (x // 2) -> x ]).

	aLayout := GtGraphHorizontalDominanceTreeLayout new.
	aLayout measure: aParentNode.
	
	self assert: aParentNode children measuredBounds equals: {
		(0.0@45.5) corner: (10.0@55.5).
		(30.0@19.5) corner: (40.0@29.5).
		(30.0@71.5) corner: (40.0@81.5).
		(60.0@6.5) corner: (70.0@16.5).
		(60.0@32.5) corner: (70.0@42.5).
		(60.0@58.5) corner: (70.0@68.5).
		(60.0@84.5) corner: (70.0@94.5).
		(90.0@0.0) corner: (100.0@10.0).
		(90.0@13.0) corner: (100.0@23.0).
		(90.0@26.0) corner: (100.0@36.0).
		(90.0@39.0) corner: (100.0@49.0).
		(90.0@52.0) corner: (100.0@62.0).
		(90.0@65.0) corner: (100.0@75.0).
		(90.0@78.0) corner: (100.0@88.0).
		(90.0@91.0) corner: (100.0@101.0)
	}.

	^ aParentNode
]
