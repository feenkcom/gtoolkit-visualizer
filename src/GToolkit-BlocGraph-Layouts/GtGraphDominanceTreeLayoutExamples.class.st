Class {
	#name : #GtGraphDominanceTreeLayoutExamples,
	#superclass : #GtGraphLayoutExamples,
	#category : #'GToolkit-BlocGraph-Layouts-Examples'
}

{ #category : #public }
GtGraphDominanceTreeLayoutExamples >> binaryTree [
	<gtExample>
	| aParentNode aLayout |

	aParentNode := self
		createGraph: 15
		extent: 10@10
		pairs: ((1 to: 15) collect: [ :x |  (x // 2) -> x ]).

	aLayout := GtGraphDominanceTreeLayout new.
	aLayout measure: aParentNode.
	
	self assert: aParentNode children measuredBounds equals: {
		(45.5@0.0) corner: (55.5@10.0).
		(19.5@30.0) corner: (29.5@40.0).
		(71.5@30.0) corner: (81.5@40.0).
		(6.5@60.0) corner: (16.5@70.0).
		(32.5@60.0) corner: (42.5@70.0).
		(58.5@60.0) corner: (68.5@70.0).
		(84.5@60.0) corner: (94.5@70.0).
		(0.0@90.0) corner: (10.0@100.0).
		(13.0@90.0) corner: (23.0@100.0).
		(26.0@90.0) corner: (36.0@100.0).
		(39.0@90.0) corner: (49.0@100.0).
		(52.0@90.0) corner: (62.0@100.0).
		(65.0@90.0) corner: (75.0@100.0).
		(78.0@90.0) corner: (88.0@100.0).
		(91.0@90.0) corner: (101.0@100.0)
	}.

	^ aParentNode
]
